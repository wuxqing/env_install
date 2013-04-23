cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

src_path="$cur_path/source"
mkdir ${src_path} -p

cd $src_path
wget http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.4.1.tgz

tar vxf $src_path/mongodb-linux-x86_64-2.4.1.tgz -C /opt/
