cd ../../
su 
mv /bin/sh /bin/sh.old
ln -s /bin/bash /bin/sh
ls -l /bin/sh
sudo - lfs
cd /mnt/lfs/sources
tar -xf gcc-13.2.0.tar.xz
cd gcc-13.2.0
tar -xf ../mpc-1.3.1.tar.gz && mv -v mpc-1.3.1 mpc
tar -xf ../gmp-6.3.0.tar.xz && mv -v gmp-6.3.0 gmp
tar -xf ../mpfr-4.2.1.tar.xz && mv -v mpfr-4.2.1 mpfr
case $(uname -m) in
x86_64)
sed -e '/m64=/s/lib64/lib/' \ -i.orig gcc/config/i386/t-linux64
;;
esac
mkdir -v build && cd build
../configure --target=$LFS_TGT --prefix=$LFS/tools --with-glibc-version=2.39 --with-sysroot=$LFS --with-newlib --without-headers --enable-default-pie --enable-default-ssp --disable-nls --disable-shared --disable-multilib --disable-threads --disable-libatomic --disable-libgomp --disable-libquadmath --disable-libssp --disable-libvtv --disable-libstdcxx --enable-languages=c,c++
make && make install
