cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

cd $cur_path/source/

wget https://redis.googlecode.com/files/redis-2.6.12.tar.gz
tar vxf $cur_path/source/redis-2.6.12.tar.gz
cd redis-2.6.12

make PREFIX=/opt/redis-2.6.12 install
