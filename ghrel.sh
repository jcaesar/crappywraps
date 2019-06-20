#!/usr/bin/env bash

set -euxo pipefail
cd "$(dirname "$0")"

API=https://api.github.com/repos/jcaesar/crappywraps
TOK="$1"

latest="$(http GET $API/releases/latest | jq -r .tag_name | sed 's/null/-1/')"
this=$(( "$latest" + 1 ))
export this

function r {
	set -euo pipefail
	cd "$0"
	tar \
		--sort=name \
		--mtime="@626637420" \
		--owner=0 --group=0 --numeric-owner \
		--exclude=\*.wrap --exclude=patch.tgz \
		-czf patch.tgz .
	name="$(basename "$PWD")"
	hash=$(sha256sum patch.tgz  | cut -d\  -f1)
	remote="https://github.com/jcaesar/crappywraps/releases/download/$this/$name-patch.tgz"
	sed -ri *.wrap \
		-e "s#(patch_url = ).*\$#\1$remote#" \
		-e "s#(patch_hash = ).*\$#\1$hash#"
}
export -f r
find * -maxdepth 0 -type d -exec bash -c r {} \;

git commit -m "Modify paths for \"release\" $this" */*.wrap
git push -f

rel="$(http --ignore-stdin --auth jcaesar:$TOK POST $API/releases tag_name=$this target_commitish=$(git rev-parse HEAD) draft:=true name="Crappy Release $this" body="Nyonyonyonyo")"
assets="$(jq -r '.upload_url' <<<"$rel" | sed 's/{?.*$//')"

for f in */*.wrap; do
	pack="$(basename "$(dirname "$f")")"
	http --auth jcaesar:$TOK "$assets" name=="$pack-patch.tgz" Content-Type:application/gzip <"$pack/patch.tgz"
done
