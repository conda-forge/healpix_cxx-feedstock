# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./src/cxx/autotools

cd src/cxx/autotools

# link and autoreconf are required to build alice
# after patching configure.ac
ln -s ../alice alice
autoreconf --install

# Add enable-pic flag so libsharp.a can be linked into libhealpix_cxx later
./configure --prefix=$PREFIX --disable-silent-rules --disable-dependency-tracking --disable-static

export EXTERNAL_CFITSIO=yes  
export CFITSIO_EXT_LIB=${PREFIX}/lib  
export CFITSIO_EXT_INC=${PREFIX}/include  

make install -j ${CPU_COUNT}

find . -name '*.h' -exec cp --parents {} ${PREFIX}/include/healpix_cxx/ \;

# delete all libsharp files as they are not needed
rm -f $PREFIX/lib/libsharp.a
rm -rf $PREFIX/include/libsharp
rm -f $PREFIX/lib/pkgconfig/libsharp.pc
