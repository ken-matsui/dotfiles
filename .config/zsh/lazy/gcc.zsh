alias gcc_conf_debug='../configure --enable-languages=c++ --disable-error --disable-bootstrap --enable-checking'
alias gcc_make_debug='make CXXFLAGS="-g3 -O0" -j8'

alias gcc_conf_release='../configure --enable-languages=c++ --disable-error --disable-bootstrap --enable-checking=release'
alias gcc_make_release='make -j8'

alias gcc_test_frontend='make check-gcc-c++'
alias gcc_test_frontend_ext='make check-gcc-c++ RUNTESTFLAGS="dg.exp=ext*"'
alias gcc_test_libstdcxx='make -j8 check-target-libstdc++-v3'

local headers='-I../../../gcc/objdir/x86_64-pc-linux-gnu/libstdc++-v3/include/x86_64-pc-linux-gnu -I../../../gcc/objdir/x86_64-pc-linux-gnu/libstdc++-v3/include -I../../../gcc/libstdc++-v3/libsupc++ -I../x86_64-pc-linux-gnu/libstdc++-v3/include/x86_64-pc-linux-gnu -I../../../gcc/libstdc++-v3/include/backward -I../../../gcc/libstdc++-v3/testsuite/util -I../../gcc/ginclude'
local cc1plus_cmd="./cc1plus $headers"

alias gcc_cc1plus="$cc1plus_cmd"
alias gcc_xgcc="./xgcc $headers"
alias gcc_xg++="./xg++ $headers"
alias gcc_gdb="gdb --args $cc1plus_cmd"
