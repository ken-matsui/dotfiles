alias conf_debug_gcc='../configure --enable-languages=c++ --disable-error --disable-bootstrap --enable-checking'
alias make_debug_gcc='make CXXFLAGS="-g3 -O0" -j8'

alias conf_release_gcc='../configure --enable-languages=c++ --disable-error --disable-bootstrap --enable-checking=release'
alias make_release_gcc='make -j8'

alias test_frontend_gcc='make check-gcc-c++ RUNTESTFLAGS="dg.exp=ext*"'
alias test_frontend_ext_gcc='make check-gcc-c++ RUNTESTFLAGS="dg.exp=ext*"'
alias test_libstdcxx_gcc='make -j8 check-target-libstdc++-v3'
