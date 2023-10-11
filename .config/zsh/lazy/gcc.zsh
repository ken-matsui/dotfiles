alias gcc_debug_conf='../configure --enable-languages=c++ --disable-error --disable-bootstrap --enable-checking'
alias gcc_debug_make='make CXXFLAGS="-g3 -O0" -j8'

alias gcc_release_conf='../configure --enable-languages=c++ --disable-error --disable-bootstrap --enable-checking=release'
alias gcc_release_make='make -j8'

alias gcc_test_frontend='make check-gcc-c++ RUNTESTFLAGS="dg.exp=ext*"'
alias gcc_test_frontend_ext='make check-gcc-c++ RUNTESTFLAGS="dg.exp=ext*"'
alias gcc_test_libstdcxx='make -j8 check-target-libstdc++-v3'
