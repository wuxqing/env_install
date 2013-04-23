cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

yum install pam-devel -y

src_path="$cur_path/source"
mkdir ${src_path} -p

monit_version="monit-5.5"

cd ${src_path}/

wget http://mmonit.com/monit/dist/${monit_version}.tar.gz
tar vxf $src_path/monit-5.5.tar.gz
cd monit-5.5
./configure --prefix=/opt/${monit_version}
make
make install

cp $cur_path/config/monitd /etc/init.d/monitd
chmod +x /etc/init.d/monitd
chkconfig --add monitd
chkconfig monitd on

cp $cur_path/config/monitrc /etc/monitrc

chmod 0700 /etc/monitrc
