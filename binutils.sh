export LFS=/mnt/lfs
cd $LFS
mount -v -t ext4 /dev/sda1 $LFS
su - lfs
cd sources
tar -xf binutils-2.42.tar.xz
cd binutils-2.42
mkdir -v build && cd build
../configure --prefix=$LFS/tools --with-sysroot=$LFS --target=$LFS_TGT --disable-nls --enable-gprofng=no --disable-werror --enable-default-hash-style=gnu
make && make install
