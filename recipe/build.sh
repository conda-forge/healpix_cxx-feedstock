
cd src/common_libraries/libsharp

./configure --prefix=$PREFIX --disable-silent-rules --disable-dependency-tracking

make install -j ${CPU_COUNT}

cd -

cd src/cxx

export SHARP_CFLAGS="-I$PREFIX/include"
export SHARP_LIBS="-L$PREFIX/lib -lsharp"

./configure --prefix=$PREFIX --disable-silent-rules --disable-dependency-tracking

make install -j ${CPU_COUNT}
