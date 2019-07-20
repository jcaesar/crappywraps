project('lz4', 'c', version: '1.9.1', license: 'BSD-2')

src = ['lib/lz4frame.c', 'lib/lz4hc.c', 'lib/lz4.c', 'lib/xxhash.c']
hdr = ['lib/lz4frame.h', 'lib/lz4hc.h', 'lib/lz4.h', 'lib/xxhash.h']

lz4 = library('lz4', src + hdr, install: true)
lz4_dep = declare_dependency(link_with: lz4)
import('pkgconfig').generate(lz4,
	version: meson.project_version(),
	name: 'lz4',
	filebase: 'lz4',
	description: 'extremely fast lossless compression algorithm library',
)
install_headers(hdr)
