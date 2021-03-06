cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

src_path="$cur_path/source"
mkdir ${src_path} -p

# 安装一些工具
yum install wget vim lsof tcpdump systemtap sysstat valgrind -y

# 安装p7zip
cd $src_path
if [ -f p7zip_9.20.1_src_all.tar.bz2 ]; then
  echo ''
else
  wget 'http://downloads.sourceforge.net/project/p7zip/p7zip/9.20.1/p7zip_9.20.1_src_all.tar.bz2?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fp7zip%2Ffiles%2Flatest%2Fdownload&ts=1359353354&use_mirror=hivelocity' -O p7zip_9.20.1_src_all.tar.bz2
fi
tar vxf $src_path/p7zip_9.20.1_src_all.tar.bz2
cd p7zip_9.20.1
make -j4
sudo make install

#cd $src_path
#wget http://dist.schmorp.de/libev/libev-4.15.tar.gz
#tar vxf $src_path/libev-4.15.tar.gz
#cd libev-4.15
#./configure
#make install

cd $src_path
if [ -f tmux-1.6.tar.gz ]; then
  echo ''
else
  wget 'http://downloads.sourceforge.net/project/tmux/tmux/tmux-1.6/tmux-1.6.tar.gz?r=&ts=1364485241&use_mirror=jaist' -O tmux-1.6.tar.gz
fi
tar vxf $src_path/tmux-1.6.tar.gz
cd tmux-1.6
./configure
make -j4
sudo make install

#git clone git://git.code.sf.net/p/tmux/tmux-code tmux
#cd tmux
#sh autogen.sh
#./configure && make

cd $src_path
if [ -f sqlite-autoconf-3071501.tar.gz ]; then
  echo ''
else
  wget http://www.sqlite.org/sqlite-autoconf-3071501.tar.gz
fi
tar vxf $src_path/sqlite-autoconf-3071501.tar.gz
cd sqlite-autoconf-3071501
CFLAGS='-O3 -DSQLITE_ENABLE_FTS3 -DSQLITE_ENABLE_FTS3_PARENTHESIS -DSQLITE_ENABLE_ICU' CPPFLAGS=`icu-config --cppflags` LDFLAGS=`icu-config --ldflags` ./configure
make -j4
sudo make install

cd $src_path
if [ -f nload-0.7.4.tar.gz ]; then
  echo ''
else
  wget 'http://downloads.sourceforge.net/project/nload/nload/0.7.4/nload-0.7.4.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fnload%2Ffiles%2Fnload%2F0.7.4%2F&ts=1365499205&use_mirror=jaist' -O nload-0.7.4.tar.gz
fi
tar vxf $src_path/nload-0.7.4.tar.gz
cd nload-0.7.4
./configure
make -j4
sudo make install
