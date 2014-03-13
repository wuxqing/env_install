cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

src_path="$cur_path/source"
mkdir ${src_path} -p

cd $src_path

if [ -f redis-2.8.7.tar.gz ]; then
  echo ''
else
  wget http://download.redis.io/releases/redis-2.8.7.tar.gz
fi

tar vxf $src_path/redis-2.8.7.tar.gz
cd redis-2.8.7

make PREFIX=/opt/redis-2.8.7 install
