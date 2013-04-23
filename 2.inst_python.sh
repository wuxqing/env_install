cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

cd $cur_path/source/
wget http://www.python.org/ftp/python/2.7.3/Python-2.7.3.tar.bz2
tar vxf $cur_path/source/Python-2.7.3.tar.bz2
cd Python-2.7.3
./configure --prefix=/opt/python-2.7.3
make
make install

cd $cur_path/source/
wget http://pypi.python.org/packages/source/s/setuptools/setuptools-0.6c11.tar.gz#md5=7df2a529a074f613b509fb44feefe74e
tar vxf $cur_path/source/setuptools-0.6c11.tar.gz
cd setuptools-0.6c11
/opt/python-2.7.3/bin/python setup.py install

#cd $cur_path/source/
#wget http://pypi.python.org/packages/source/v/virtualenvwrapper/virtualenvwrapper-3.6.tar.gz#md5=57d78305b75750a40985f206c80a280f
#tar vxf virtualenvwrapper-3.6.tar.gz
#cd virtualenvwrapper-3.6
#/opt/python-2.7.3/bin/python setup.py install

/opt/python-2.7.3/bin/easy_install virtualenvwrapper

mkdir /work

echo "export VIRTUALENVWRAPPER_PYTHON=/opt/python-2.7.3/bin/python" >> ~/.bashrc
echo "source /opt/python-2.7.3/bin/virtualenvwrapper.sh" >> ~/.bashrc
echo "export WORKON_HOME=/work/" >> ~/.bashrc
echo "PATH=\$PATH:/opt/python-2.7.3/bin" >> ~/.bash_profile
echo "export PATH" >> ~/.bash_profile
