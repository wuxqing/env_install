cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

src_path="$cur_path/source"
mkdir ${src_path} -p

cd $src_path
if [ -f mongodb-linux-x86_64-2.4.1.tgz ]; then
  echo ''
else
  wget http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.4.1.tgz
fi

tar vxf $src_path/mongodb-linux-x86_64-2.4.1.tgz -C /opt/
