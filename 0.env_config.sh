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
git clone git://canonware.com/jemalloc.git
cd jemalloc
sh autogen.sh
