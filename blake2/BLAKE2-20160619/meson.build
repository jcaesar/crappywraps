project('blake2', 'c')

inc = include_directories('ref')
lib = static_library('blake2',
    include_directories: inc,
    sources: [
        'ref/blake2bp-ref.c',
        'ref/blake2b-ref.c',
        'ref/blake2sp-ref.c',
        'ref/blake2s-ref.c',
        'ref/blake2xb-ref.c',
        'ref/blake2xs-ref.c',
    ]
)
blake2_dep = declare_dependency(
    link_with: lib,
    include_directories: inc
)
