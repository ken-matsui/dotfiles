alias gcc_conf_debug='../configure --enable-languages=c++ --disable-error --disable-bootstrap --enable-checking'
alias gcc_make_debug='make CXXFLAGS="-g3 -O0" -j8'

alias gcc_conf_release='../configure --enable-languages=c++ --disable-error --disable-bootstrap --enable-checking=release'
alias gcc_make_release='make -j8'

alias gcc_test_frontend='make check-gcc-c++'
alias gcc_test_frontend_ext='make check-gcc-c++ RUNTESTFLAGS="dg.exp=ext*"'
alias gcc_test_libstdcxx='make -j8 check-target-libstdc++-v3'

export GCC_SRC_DIR="$HOME/gcc"
export GCC_OBJ_DIR="$GCC_SRC_DIR/objdir"
export GCC_OUT_DIR="$GCC_OBJ_DIR/gcc"
export PATH="$PATH:$GCC_OUT_DIR"

local headers="-I$GCC_OBJ_DIR/x86_64-pc-linux-gnu/libstdc++-v3/include/x86_64-pc-linux-gnu -I$GCC_OBJ_DIR/x86_64-pc-linux-gnu/libstdc++-v3/include -I$GCC_SRC_DIR/libstdc++-v3/libsupc++ -I$GCC_OBJ_DIR/x86_64-pc-linux-gnu/libstdc++-v3/include/x86_64-pc-linux-gnu -I$GCC_SRC_DIR/libstdc++-v3/include/backward -I$GCC_SRC_DIR/libstdc++-v3/testsuite/util -I$GCC_SRC_DIR/gcc/ginclude"

alias gcc_cc1plus="cc1plus $headers"
alias gcc_xgcc="xgcc $headers"
alias gcc_xg++="xg++ $headers"
alias gcc_gdb="gdb --args $gcc_cc1plus"
