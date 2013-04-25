# 适合redhat系列OS的安装 
#
# 注意
# 编译需要安装bison, 可以通过 yum install bison 来安装
#
# 已知问题：my.cnf中为何要用root帐号执行
# 已知问题：只有方法3才能启动

cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

yum install bison ncurses-devel cmake libaio-devel gcc-c++ -y

src_path="$cur_path/source"
percona_version='Percona-Server-5.5.21-rel25.0'
mysql_path="/opt/"$percona_version
mysql_data_path="/data/server/mysql"

mkdir ${src_path} -p
mkdir ${mysql_path} -p

# 添加mysql用户组和用户
groupadd  mysql
useradd   mysql -g mysql  -s /sbin/nologin
useradd -M -r -s /sbin/nologin -d $mysql_data_path mysql

cd ${src_path}

# 下载mysql源代码
# http://www.percona.com/downloads/Percona-Server-5.5/
wget http://www.percona.com/redir/downloads/Percona-Server-5.5/Percona-Server-5.5.21-25.0/source/Percona-Server-5.5.21-rel25.0.tar.gz

# 在CentOS 5.6上无法编译通过
# wget http://www.percona.com/redir/downloads/Percona-Server-5.5/Percona-Server-5.5.14-20.5/source/Percona-Server-5.5.14-rel20.5.tar.gz

# 在CentOS 6上无法编译通过
# wget http://www.percona.com/redir/downloads/Percona-Server-5.5/Percona-Server-5.5.16-22.0/source/Percona-Server-5.5.16-rel22.0.tar.gz

tar zxf $src_path/${percona_version}.tar.gz 
cd ${src_path}/${percona_version}

# 可以通过  cmake . -LH 查看有哪些可选择的编译参数.

cmake . \
  -DSYSCONFDIR:PATH=${mysql_path}               \
  -DCMAKE_INSTALL_PREFIX:PATH=${mysql_path}     \
  -DMYSQL_DATADIR:PATH=${mysql_data_path}       \
  -DMYSQL_UNIX_ADDR=/tmp/mysqld.sock   \
  -DCMAKE_BUILD_TYPE:STRING=Release             \
  -DENABLED_PROFILING:BOOL=ON                   \
  -DENABLE_DEBUG_SYNC:BOOL=OFF                  \
  -DINSTALL_LAYOUT:STRING=STANDALONE            \
  -DMYSQL_MAINTAINER_MODE:BOOL=OFF              \
  -DWITH_DEBUG:BOOL=OFF                         \
  -DWITH_EXTRA_CHARSETS=all \
  -DWITH_EMBEDDED_SERVER:BOOL=OFF               \
  -DWITH_PARTITION_STORAGE_ENGINE:BOOL=ON       \
  -DWITH_SSL:STRING=no                          \
  -DWITH_UNIT_TESTS:BOOL=OFF                    \
  -DWITH_READLINE:BOOL=OFF                      \
  -DWITH_VALGRIND:BOOL=OFF                      \
  -DWITH_ZLIB:STRING=bundled                    \
  -DCOMMUNITY_BUILD:BOOL=ON                     \
  -DMYSQL_USER=mysql                            \
  -DENABLE_DTRACE=OFF                           \
  -LH

make
make install

echo "${mysql_path}/lib/" > /etc/ld.so.conf.d/opt_mysql_lib.conf
echo "${mysql_path}/lib/plugin" >> /etc/ld.so.conf.d/opt_mysql_lib.conf
ldconfig

cp ${src_path}/${percona_version}/support-files/my-innodb-heavy-4G.cnf ${mysql_path}/my.cnf

# 开始安装数据
chmod 700 ${src_path}/${percona_version}/scripts/mysql_install_db
${src_path}/${percona_version}/scripts/mysql_install_db --defaults-file=${mysql_path}/my.cnf --basedir=${mysql_path} --datadir=${mysql_data_path} --pid-file=${mysql_path}/mysql.pid --user=mysql 

chown mysql:mysql -R ${mysql_data_path}

echo "启动mysql服务:" 
echo "  方法1： ${mysql_path}/bin/mysqld_safe &" 
echo "  方法2： ${mysql_path}/bin/mysqld_safe --defaults-file=${mysql_path}/my.cnf &" 
echo "  方法3： ${mysql_path}/bin/mysqld_safe --defaults-file=${mysql_path}/my.cnf --datadir=${mysql_data_path} &"
echo "" 
echo "修改mysql的root密码:" 
echo "  方法1： ${mysql_path}/bin/mysqladmin -u root password 'db@Pwd.fk_peak'"
echo "  方法2： ${mysql_path}/bin/mysqladmin -u root -h peak.jcing.com password 'new-password'"
echo "" 
echo "  或者采用交互的方式:" 
echo "  ${mysql_path}/bin/mysql_secure_installation"
echo "" 
echo "测试数据库"
echo "${mysql_path}/bin/mysql -uroot -p"
echo "" 
echo "输入密码"
echo "" 
echo "显示数据库"
echo "show databases;"
echo "" 
echo "设置远程访问权限"
echo "grant select,insert,update,delete,drop,create on trader.* to 'trader'@\"192.168.2.100\" identified by 'china_Game_Town_PWD';"
echo "" 
echo "退出"
echo "quit;"

# 建立客户端链接
# 如果已经安装了mysql客户端的话.
# 把原来的mysql备份
# mv /usr/bin/mysql /usr/bin/mysql.bak
ln -s ${mysql_path}/bin/mysql /usr/bin/mysql

# 添加mysql为系统服务
cp ${src_path}/${percona_version}/support-files/mysql.server /etc/init.d/mysqld
chmod +x /etc/init.d/mysqld
chkconfig --add mysqld
chkconfig mysqld on
#cp ${src_path}/${percona_version}/support-files/mysql.server /etc/rc.d/init.d/mysqld
#chmod 700 /etc/rc.d/init.d/mysqld
#chkconfig --add mysqld
#chkconfig --level 345 mysqld on
#chmod 755 /etc/init.d/mysqld

# 启动mysql服务
# service mysqld start
