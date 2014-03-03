cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

src_path="$cur_path/source"
mkdir ${src_path} -p
cd $src_path

wget wget http://ftp.postgresql.org/pub/source/v9.3.2/postgresql-9.3.2.tar.bz2
tar vxf $src_path/postgresql-9.3.2.tar.bz2
cd postgresql-9.3.2

./configure --prefix=/opt/postgresql-9.3.2
make && sudo make install

echo "/opt/postgresql-9.3.2/lib/" > /etc/ld.so.conf.d/opt_postgresql_lib.conf
ldconfig



