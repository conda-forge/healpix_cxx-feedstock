# Build libsharp
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./src/common_libraries/libsharp
cp $BUILD_PREFIX/share/gnuconfig/config.* ./src/cxx
cd src/common_libraries/libsharp

# Add enable-pic flag so libsharp.a can be linked into libhealpix_cxx later
./configure --prefix=$PREFIX --disable-silent-rules --disable-dependency-tracking --disable-shared --enable-pic

make install -j ${CPU_COUNT}

cd -

cd src/cxx

# Build libhealpix_cxx
export SHARP_CFLAGS="-I$PREFIX/include"
export SHARP_LIBS="-L$PREFIX/lib -lsharp"

./configure --prefix=$PREFIX --disable-silent-rules --disable-dependency-tracking --disable-static

make install -j ${CPU_COUNT}

cd -

# delete all libsharp files as they are not needed
rm -f  $PREFIX/lib/libsharp.a
mkdir -p $PREFIX/include/healpix_cxx
mv $PREFIX/include/libsharp $PREFIX/include/healpix_cxx
rm -rf $PREFIX/lib/pkgconfig/libsharp.pc


# Copy and rename the libsharp lisence
cp src/common_libraries/libsharp/COPYING COPYING-libsharp
