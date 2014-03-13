cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

src_path="$cur_path/source"
mkdir ${src_path} -p

# 安装开发环境
yum install gcc gcc-c++ make automake autoconf213 autoconf bison ncurses cmake libtool bison flex perl git subversion mercurial -y

# 安装开发库
yum install pam-devel openssl-devel pcre-devel zlib-devel libjpeg-devel libtiff-devel libpng-devel freetype-devel boost-devel libevent-devel libuuid-devel readline-devel bzip2-devel \
    libxml2-devel libxslt-devel openssl-devel kernel-devel libpcap-devel ncurses-devel libaio libaio-devel libicu libicu-devel -y

cd $src_path
if [ -f jemalloc-3.5.1.tar.bz2 ]; then
  echo ''
else
wget http://www.canonware.com/download/jemalloc/jemalloc-3.5.1.tar.bz2
fi
tar vxf jemalloc-3.5.1.tar.bz2
cd jemalloc-3.5.1
sh autogen.sh
