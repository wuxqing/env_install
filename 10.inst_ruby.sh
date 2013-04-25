cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

src_path="$cur_path/source"
mkdir ${src_path} -p

cd $src_path

wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p392.tar.gz
tar vxf $src_path/ruby-1.9.3-p392.tar.gz
cd ruby-1.9.3-p392
./configure --prefix=/opt/ruby-1.9.3-p392
make
make install

# 更改GEM软件源
# 删除缺省的源 
gem sources -r https://rubygems.org/

# 添加taobao源
gem sources -a http://ruby.taobao.org/

# 安装 bundler 
gem install bundler 
