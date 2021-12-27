
cd src/common_libraries/libsharp

./configure --prefix=$PREFIX --disable-silent-rules --disable-dependency-tracking --disable-shared

if [ "$(uname)" == "Darwin" ]; then

    sed -i '' 's/-O2/-O2 -fPIC/g' config.status
    sed -i '' 's/-O3/-O3 -fPIC/g' config.status

else

    sed -i 's/-O2/-O2 -fPIC/g' config.status
    sed -i 's/-O3/-O3 -fPIC/g' config.status

fi

./config.status

make install -j ${CPU_COUNT}

cd -

cd src/cxx

export SHARP_CFLAGS="-I$PREFIX/include"
export SHARP_LIBS="-L$PREFIX/lib -lsharp"

./configure --prefix=$PREFIX --disable-silent-rules --disable-dependency-tracking --disable-shared

make install -j ${CPU_COUNT}

cd -

${CC} -shared -o $PREFIX/lib/libhealpix_cxx.so -Wl,--whole-archive $PREFIX/lib/libsharp.a $PREFIX/lib/libhealpix_cxx.a -Wl,--no-whole-archive ${CFLAGS} ${LDFLAGS}
rm $PREFIX/lib/libsharp.a
rm $PREFIX/lib/libhealpix_cxx.a

#Copy and rename the libsharp lisence
cp src/common_libraries/libsharp/COPYING COPYING-libsharp
