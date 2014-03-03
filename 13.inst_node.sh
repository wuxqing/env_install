cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

src_path="$cur_path/source"
mkdir ${src_path} -p

node_path="/opt/node-0.10.9"

cd $src_path

wget http://nodejs.org/dist/v0.10.9/node-v0.10.9.tar.gz
tar vxf $src_path/node-v0.10.9.tar.gz
cd node-v0.10.9

./configure --prefix=${node_path}
make && make install


