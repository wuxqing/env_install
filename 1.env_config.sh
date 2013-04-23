cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

# 安装开发环境
yum install gcc gcc-c++ make automake autoconf213 autoconf bison ncurses cmake libtool bison flex perl git subversion mercurial python-setuptools -y

# 安装开发库
yum install pam-devel openssl-devel pcre-devel zlib-devel libjpeg-devel libpng-devel freetype-devel boost-devel libevent-devel libuuid-devel readline-devel bzip2-devel libxml2-devel libxslt-devel openssl-devel kernel-devel pcre-devel boost-devel python-devel libpcap-devel ncurses-devel libaio libaio-devel libicu libicu-devel -y

# 安装一些工具
yum install wget vim lsof tcpdump systemtap valgrind -y

# 安装p7zip
cd $cur_path/source/
wget 'http://downloads.sourceforge.net/project/p7zip/p7zip/9.20.1/p7zip_9.20.1_src_all.tar.bz2?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fp7zip%2Ffiles%2Flatest%2Fdownload&ts=1359353354&use_mirror=hivelocity'
tar vxf $cur_path/source/p7zip_9.20.1_src_all.tar.bz2
cd p7zip_9.20.1
make
make install

#cd $cur_path/source/
#wget http://dist.schmorp.de/libev/libev-4.15.tar.gz
#tar vxf $cur_path/source/libev-4.15.tar.gz
#cd libev-4.15
#./configure
#make install

cd $cur_path/source/
wget 'http://downloads.sourceforge.net/project/tmux/tmux/tmux-1.6/tmux-1.6.tar.gz?r=&ts=1364485241&use_mirror=jaist'
tar vxf $cur_path/source/tmux-1.6.tar.gz
cd tmux-1.6
./configure
make install

#git clone git://git.code.sf.net/p/tmux/tmux-code tmux
#cd tmux
#sh autogen.sh
#./configure && make

cd $cur_path/source/
wget http://www.sqlite.org/sqlite-autoconf-3071501.tar.gz
tar vxf $cur_path/source/sqlite-autoconf-3071501.tar.gz
cd sqlite-autoconf-3071501
CFLAGS='-O3 -DSQLITE_ENABLE_FTS3 -DSQLITE_ENABLE_FTS3_PARENTHESIS -DSQLITE_ENABLE_ICU' CPPFLAGS=`icu-config --cppflags` LDFLAGS=`icu-config --ldflags` ./configure
make
make install

cd $cur_path/source/
wget http://downloads.sourceforge.net/project/nload/nload/0.7.4/nload-0.7.4.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fnload%2Ffiles%2Fnload%2F0.7.4%2F&ts=1365499205&use_mirror=jaist
tar vxf $cur_path/source/nload-0.7.4.tar.gz
cd nload-0.7.4
./configure
make install

mkdir /work/log/ -p
