#!/usr/bin/env bash

set -eu

cd "$(dirname "$0")"

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
	remote="http://cloudflare-ipfs.com/ipfs/$(ssh -q jdw go-ipfs/ipfs add -Q - <patch.tgz)"
	sed -ri *.wrap \
		-e "s#(patch_url = ).*\$#\1$remote#" \
		-e "s#(patch_hash = ).*\$#\1$hash#"
}
export -f r

find * -maxdepth 0 -type d -exec bash -c r {} \;
