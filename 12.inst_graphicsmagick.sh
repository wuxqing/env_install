cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

src_path="$cur_path/source"
mkdir ${src_path} -p

graphics_magick_path="/opt/GraphicsMagick-1.3.18"

cd $src_path

yum install libjpeg-turbo-devel freetype-devel libpng-devel libtiff-devel boost-devel

#wget http://78.108.103.11/MIRROR/ftp/GraphicsMagick/GraphicsMagick-LATEST.tar.bz2
wget http://78.108.103.11/MIRROR/ftp/GraphicsMagick/1.3/GraphicsMagick-1.3.18.tar.bz2
tar vxf $src_path/GraphicsMagick-1.3.18.tar.bz2
cd GraphicsMagick-1.3.18

./configure --with-quantum-depth=8  --enable-shared=yes
#--prefix=${graphics_magick_path}
make && make install

#echo "${graphics_magick_path}/lib/" > /etc/ld.so.conf.d/opt_graphics_magick_lib.conf
ldconfig



