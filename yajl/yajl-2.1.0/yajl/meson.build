# https://github.com/mesonbuild/meson/issues/2546
install_headers(hdr, subdir: 'yajl')
foreach h: hdr
	configure_file(
		copy: true,
		input: h,
		output: '@PLAINNAME@',
	)
endforeach
