cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

cd $cur_path/source/

wget ftp://ftp.kddlabs.co.jp/graphics/ImageMagick/ImageMagick-6.7.9-6.tar.bz2
tar vxf $cur_path/source/ImageMagick-6.7.9-6.tar.bz2
cd ImageMagick-6.7.9-6

./configure --with-quantum-depth=8
make && make install

ldconfig /usr/local/lib/
