project('tinyxml', 'cpp',
    version : '6.2.0',
    #default_options : ['c_std=c11', 'cpp_std=c++14'],
)

tinyxml_dep = declare_dependency(
	link_with: static_library('tinyxml',
		sources: [
			'tinystr.cpp',
			'tinyxml.cpp',
			'tinyxmlerror.cpp',
			'tinyxmlparser.cpp',
		]
	),
	include_directories: include_directories('.'),
)
