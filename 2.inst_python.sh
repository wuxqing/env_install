cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

src_path="$cur_path/source"
mkdir ${src_path} -p

cd $src_path
wget http://www.python.org/ftp/python/2.7.6/Python-2.7.6.tgz
tar vxf $src_path/Python-2.7.6.tar.bz2
cd Python-2.7.6
./configure --prefix=/opt/python-2.7.6
make
make install

cd $src_path
curl -O http://python-distribute.org/distribute_setup.py
/opt/python-2.7.6/bin/python distribute_setup.py

#wget http://pypi.python.org/packages/source/s/setuptools/setuptools-0.6c11.tar.gz#md5=7df2a529a074f613b509fb44feefe74e
#tar vxf $src_path/setuptools-0.6c11.tar.gz
#cd setuptools-0.6c11
#/opt/python-2.7.6/bin/python setup.py install

#cd $src_path
#wget http://pypi.python.org/packages/source/v/virtualenvwrapper/virtualenvwrapper-3.6.tar.gz#md5=57d78305b75750a40985f206c80a280f
#tar vxf virtualenvwrapper-3.6.tar.gz
#cd virtualenvwrapper-3.6
#/opt/python-2.7.6/bin/python setup.py install

/opt/python-2.7.6/bin/easy_install virtualenv==1.9

mkdir /work -p

echo "PATH=\$PATH:/opt/python-2.7.6/bin" >> ~/.bash_profile
echo "export PATH" >> ~/.bash_profile
