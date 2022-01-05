cd src/cxx/autotools

# link and autoreconf are required to build alice
# after patching configure.ac
ln -s ../alice alice
autoreconf --install

export CPATH="${PREFIX}/include"

./configure --prefix=$PREFIX --disable-silent-rules --disable-dependency-tracking --disable-static

make -j ${CPU_COUNT} install

# don't export libsharp include files
rm -rf $PREFIX/include/libsharp
rm -rf $PREFIX/include/healpix_cxx/sharp*.h
rm -rf $PREFIX/include/healpix_cxx/sharp*.c



