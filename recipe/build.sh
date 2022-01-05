cd src/cxx/autotools

ln -s ../alice alice

autoreconf --install

export CPATH="${PREFIX}/include"

./configure --prefix=$PREFIX --disable-dependency-tracking

make -j ${CPU_COUNT}
make install


