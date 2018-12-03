project('tinyxml', 'cpp',
	version : '6.2.0',
	#default_options : ['c_std=c11', 'cpp_std=c++14'],
)

headers = ['tinyxml.h', 'tinystr.h']

tinyxml_lib = static_library('tinyxml',
	sources: [
		'tinystr.cpp',
		'tinyxml.cpp',
		'tinyxmlerror.cpp',
		'tinyxmlparser.cpp',
	] + headers,
	install: true,
)

tinyxml_dep = declare_dependency(
	link_with: tinyxml_lib,
	include_directories: include_directories('.'),
)

install_headers(headers, subdir: 'tinyxml')

import('pkgconfig').generate(
	libraries: tinyxml_lib,
	subdirs: 'tinyxml',
	version: '6.2.0',
	name: 'tinyxml',
	filebase: 'tinyxml',
	description: 'TinyXML'
)
