sudo mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin} $LFS/tools
for i in bin lib sbin; do
    sudo ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
    x86_64) sudo mkdir -pv $LFS/lib64 ;;
esac
sudo groupadd lfs
sudo useradd -s /bin/bash -g lfs -m -k /dev/null lfs
echo "enter ur password of the distrubition"
sudo passwd lfs
sudo chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
case $(uname -m) in
    x86_64) sudo chown -v lfs $LFS/lib64 ;;
esac
sudo su - lfs
cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
export MAKEFLAGS=-j$(nproc)
EOF

source ~/.bash_profile
