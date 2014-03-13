cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

src_path="$cur_path/source"
mkdir ${src_path} -p

cd $src_path

if [ -f ImageMagick-6.7.9-6.tar.bz2 ]; then
  echo ''
else
  wget ftp://ftp.kddlabs.co.jp/graphics/ImageMagick/ImageMagick-6.7.9-6.tar.bz2
fi

tar vxf $src_path/ImageMagick-6.7.9-6.tar.bz2
cd ImageMagick-6.7.9-6

./configure --with-quantum-depth=8
make && make install

ldconfig /usr/local/lib/
