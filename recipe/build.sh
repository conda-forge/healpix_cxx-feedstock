# Build libsharp
cd src/common_libraries/libsharp

# Add -fPIC flag so libsharp.a can be linked into libhealpix_cxx later
CXXFLAGS=-fPIC CFLAGS=-fPIC ./configure --prefix=$PREFIX --disable-silent-rules --disable-dependency-tracking --disable-shared

make install -j ${CPU_COUNT}

cd -

cd src/cxx

# Build libhealpix_cxx
export SHARP_CFLAGS="-I$PREFIX/include"
export SHARP_LIBS="-L$PREFIX/lib -lsharp"

./configure --prefix=$PREFIX --disable-silent-rules --disable-dependency-tracking --disable-static

make install -j ${CPU_COUNT}

cd -

rm $PREFIX/lib/libsharp.a

# Copy and rename the libsharp lisence
cp src/common_libraries/libsharp/COPYING COPYING-libsharp
