project('lz4', 'c', version: '1.9.1', license: 'BSD-2')

basehdr = 'lib/lz4.h'
src = ['lib/lz4frame.c', 'lib/lz4hc.c', 'lib/lz4.c', 'lib/xxhash.c']
hdr = ['lib/lz4frame.h', 'lib/lz4hc.h', basehdr]
default_library = get_option('default_library')
if default_library != 'shared'
	hdr += 'lib/lz4frame_static.h'
endif

GetLz4LibraryVersion_py = files('contrib/meson/GetLz4LibraryVersion.py')
r = run_command(import('python').find_installation(), GetLz4LibraryVersion_py, basehdr)
if r.returncode() == 0
	output = r.stdout().strip()
	if not output.version_compare(meson.project_version())
		error('Meson project version @0@ does not match @1@ version @2@'.format(meson.project_version(), basehdr, output))
	endif
else
	warning('Unable to check version of @0@'.format(basehdr))
endif

cc = meson.get_compiler('c')
c_args = []
debug_cflags = []
if get_option('debug')
	c_args += '-DLZ4_DEBUG=@0@'.format(get_option('debug_level'))
	if ['gcc', 'clang'].contains(cc.get_id())
		debug_cflags = ['-Wextra', '-Wcast-qual', '-Wcast-align', '-Wshadow',
		                '-Wswitch-enum', '-Wdeclaration-after-statement', '-Wstrict-prototypes',
		                '-Wundef', '-Wpointer-arith', '-Wstrict-aliasing=1']
	endif
endif
c_args += cc.get_supported_arguments(debug_cflags)

if host_machine.system() == 'windows' and default_library != 'static'
	c_args += '-DLZ4_DLL_EXPORT=1'
endif

lz4 = library('lz4', src + hdr + [ 'lib/xxhash.h' ], c_args: c_args, install: true)
lz4_dep = declare_dependency(link_with: lz4)
liblz4_dep = lz4_dep # I hate everything about the lib prefix.
import('pkgconfig').generate(lz4,
	version: meson.project_version(),
	name: 'lz4',
	filebase: 'lz4',
	description: 'extremely fast lossless compression algorithm library',
)
install_headers(hdr)
