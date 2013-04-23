cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

cd $cur_path/source/
wget http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.4.1.tgz

tar vxf $cur_path/source/mongodb-linux-x86_64-2.4.1.tgz -C /opt/
