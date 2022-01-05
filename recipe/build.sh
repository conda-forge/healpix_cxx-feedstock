cd src/cxx/autotools

ln -s ../alice alice

autoreconf -i

export CPATH="${PREFIX}/include"

./configure --prefix=$PREFIX

make -j ${CPU_COUNT}
make install


