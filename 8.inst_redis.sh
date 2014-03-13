cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

src_path="$cur_path/source"
mkdir ${src_path} -p

cd $src_path

if [ -f redis-2.6.14.tar.gz ]; then
  echo ''
else
  wget https://redis.googlecode.com/files/redis-2.6.14.tar.gz
fi

tar vxf $src_path/redis-2.6.14.tar.gz
cd redis-2.6.14

make PREFIX=/opt/redis-2.6.14 install
