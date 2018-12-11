cd src/cxx

autoconf

export CPATH="${PREFIX}/include"

./configure --prefix=$PREFIX --enable-noisy-make

# We need to manually add -fPIC because there is no way
# to force healpix to use it otherwise. We accomplish this
# by changing the status and then instantiating it

if [ "$(uname)" == "Darwin" ]; then
    
    sed -i '' 's/-O2/-O2 -fPIC/g' config.status
    sed -i '' 's/-O3/-O3 -fPIC/g' config.status

else

    sed -i 's/-O2/-O2 -fPIC/g' config.status
    sed -i 's/-O3/-O3 -fPIC/g' config.status
    
fi

./config.status

make -j ${CPU_COUNT}

# There is no "make install", so we do it manually
cp -r auto/lib/* ${PREFIX}/lib
mkdir ${PREFIX}/include/healpix_cxx
cp -r auto/include/* ${PREFIX}/include/healpix_cxx
cp -r auto/bin/* ${PREFIX}/bin

