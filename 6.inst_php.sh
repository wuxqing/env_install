cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

# 安装最新版本PHP（ PHP5.3.14 ）
src_path="$cur_path/source"
mkdir ${src_path} -p

php_version="php-5.4.11"
percona_version='Percona-Server-5.5.21-rel25.0'
mysql_path="/opt/"$percona_version

cd ${src_path}
if [ -f ${php_version}.tar.bz2 ]; then
  echo ''
else
  wget http://cn2.php.net/get/${php_version}.tar.bz2/from/this/mirror
fi

tar xjvf $src_path/${php_version}.tar.bz2
cd ${php_version}

# 执行：
./buildconf --force

# 如果报错，可能是你的 autoconf不是 2.13 版本的，PHP5.3.系列的bug，需要安装 autoconf为2.13的版本：
# CentOS ： # yum install autoconf213
# Debian ： # apt-get install autoconf2.13

# 设置环境变量
# CentOS ：
# export PHP_AUTOCONF="/usr/bin/autoconf-2.13"
# Debian ：
# export PHP_AUTOCONF="/usr/bin/autoconf2.13"

# 再次运行：./buildconf --force ，出现 buildconf: autoconf version 2.13 (ok)，则表示成功。
# 编译安装 PHP
./configure \
  --prefix=/opt/${php_version} \
  --with-config-file-path=/opt/${php_version}/etc \
  --with-config-file-scan-dir=/opt/${php_version}/etc/conf.d \
  --enable-fpm \
  --with-fpm-user=www \
  --with-fpm-group=www \
  --with-mysql=${mysql_path} \
  --with-mysqli=${mysql_path}/bin/mysql_config \
  --with-iconv-dir \
  --with-freetype-dir \
  --with-jpeg-dir \
  --with-png-dir \
  --with-zlib \
  --with-libxml-dir \
  --enable-xml \
  --enable-mbstring \
  --with-gd \
  --enable-gd-native-ttf \
  --with-openssl \
  --enable-inline-optimization
          
make && make install
cp php.ini-production /opt/${php_version}/etc/php.ini
cd /opt/${php_version}/etc
#cp php-fpm.conf.default php-fpm.conf
cp $cur_path/config/php-fpm.conf php-fpm.conf

#修改php-fpm.conf 启用如下几行，即去掉前面的分号(;)
#pid = run/php-fpm.pid
#error_log = log/php-fpm.log
#log_level = notice
#listen = 127.0.0.1:9000
#listen.allowed_clients = 127.0.0.1
#listen.owner = www
#listen.group = www
#listen.mode = 0666
#user = www
#group = www
#pm = dynamic
#pm.max_children = 50
#pm.start_servers = 5
#pm.min_spare_servers = 5
#pm.max_spare_servers = 35
#pm.max_requests = 500
#env[HOSTNAME] = $HOSTNAME
#env[PATH] = /usr/local/bin:/usr/bin:/bin
#env[TMP] = /tmp
#env[TMPDIR] = /tmp
#env[TEMP] = /tmp

#8、启动php-fpm
#/opt/${php_version}/sbin/php-fpm
