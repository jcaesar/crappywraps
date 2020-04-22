# hack for https://github.com/mesonbuild/meson/issues/2546
install_headers(headers, subdir: 'readline')
foreach h: headers
	configure_file(
		copy: true,
		input: h,
		output: '@PLAINNAME@',
	)
endforeach
