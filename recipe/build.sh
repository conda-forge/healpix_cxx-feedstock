
cd src/common_libraries/libsharp

./configure --prefix=$PREFIX --disable-silent-rules --disable-dependency-tracking

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

./configure --prefix=$PREFIX --disable-silent-rules --disable-dependency-tracking --enable-shared

make install -j ${CPU_COUNT}
