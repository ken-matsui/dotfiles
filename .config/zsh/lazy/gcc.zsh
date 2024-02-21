alias conf_debug_gcc='../configure --enable-languages=c++ --disable-error --disable-bootstrap --enable-checking'
alias make_debug_gcc='make CXXFLAGS="-g3 -O0" -j8'

alias conf_release_gcc='../configure --enable-languages=c++ --disable-error --disable-bootstrap --enable-checking=release'
alias make_release_gcc='make -j8'

alias test_frontend_gcc='make check-gcc-c++ RUNTESTFLAGS="dg.exp=ext*"'
alias test_frontend_ext_gcc='make check-gcc-c++ RUNTESTFLAGS="dg.exp=ext*"'
alias test_libstdcxx_gcc='make -j8 check-target-libstdc++-v3'

local CC1PLUS_CMD='./cc1plus -I../../../gcc/objdir/x86_64-pc-linux-gnu/libstdc++-v3/include/x86_64-pc-linux-gnu -I../../../gcc/objdir/x86_64-pc-linux-gnu/libstdc++-v3/include -I../../../gcc/libstdc++-v3/libsupc++ -I../x86_64-pc-linux-gnu/libstdc++-v3/include/x86_64-pc-linux-gnu -I../../../gcc/libstdc++-v3/include/backward -I../../../gcc/libstdc++-v3/testsuite/util -I../../gcc/ginclude'
alias gcc_compile='eval $CC1PLUS_CMD'
alias gcc_gdb='eval gdb --args $CC1PLUS_CMD'
