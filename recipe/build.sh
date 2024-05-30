# Build libsharp
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/libtool/build-aux/config.* .

# Add enable-pic flag so libsharp.a can be linked into libhealpix_cxx later
./configure --prefix=$PREFIX --disable-silent-rules --disable-dependency-tracking

make install -j ${CPU_COUNT}
