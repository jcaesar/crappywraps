project('YetAnotherJSONParser', 'c', version: '2.1.0')
version = configuration_data({
	'yajl_major': 2,
	'yajl_minor': 1,
	'yajl_micro': 0,
})
api = files(
	'src/api/yajl_common.h',
	'src/api/yajl_gen.h',
	'src/api/yajl_parse.h',
	'src/api/yajl_tree.h',
)
subdir('meson-include/yajl')
src = api + files(
	'src/yajl.c',
	'src/yajl_alloc.c',
	'src/yajl_alloc.h',
	'src/yajl_buf.c',
	'src/yajl_buf.h',
	'src/yajl_bytestack.h',
	'src/yajl_encode.c',
	'src/yajl_encode.h',
	'src/yajl_gen.c',
	'src/yajl_lex.c',
	'src/yajl_lex.h',
	'src/yajl_parser.c',
	'src/yajl_parser.h',
	'src/yajl_tree.c',
	'src/yajl_version.c',
)
configure_file(configuration: version,
	input: 'src/api/yajl_version.h.cmake',
	output: 'yajl_version.h',
	install: true,
	install_dir: 'include/yajl',
)
yajl = library('yajl', src,
	include_directories: '.',
	install: true
)
yajl_dep = declare_dependency(
	link_with: yajl,
	include_directories: include_directories('meson-include'),
)
import('pkgconfig').generate(libraries: yajl,
	subdirs: 'yajl',
	version : meson.project_version(),
	name : 'Yet Another JSON Library',
	filebase : 'yajl',
	description : 'A Portable JSON parsing and serialization library in ANSI C'
)
