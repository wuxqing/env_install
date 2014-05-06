cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

src_path="$cur_path/source"
mkdir ${src_path} -p

cd $src_path
if [ -f Python-3.4.0.tar.xz ]; then
  echo ''
else
  wget http://www.python.org/ftp/python/3.4.0/Python-3.4.0.tar.xz
fi

tar vxf $src_path/Python-3.4.0.tar.xz
cd Python-3.4.0
./configure --prefix=/opt/python-3.4.0
make -j4
sudo make install

#cd $src_path
#curl -O http://python-distribute.org/distribute_setup.py
#sudo /opt/python-3.4.0/bin/python3 distribute_setup.py
#sudo /opt/python-3.4.0/bin/easy_install-3.4 virtualenv

#echo "PATH=\$PATH:/opt/python-2.7.6/bin" >> ~/.bash_profile
#echo "export PATH" >> ~/.bash_profile
