# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./src/cxx/autotools

cd src/cxx/autotools

# link and autoreconf are required to build alice
# after patching configure.ac
ln -s ../alice alice
autoreconf --install

# Add enable-pic flag so libsharp.a can be linked into libhealpix_cxx later
./configure --prefix=$PREFIX --disable-silent-rules --disable-dependency-tracking --disable-static

make install -j ${CPU_COUNT}

find .. -name '*.h' -exec cp {} ${PREFIX}/include/healpix_cxx/ \;

# delete all libsharp files as they are not needed
rm -f $PREFIX/lib/libsharp.a
rm -rf $PREFIX/include/libsharp
rm -f $PREFIX/lib/pkgconfig/libsharp.pc
