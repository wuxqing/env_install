http://tengine.taobao.org/download/tengine-1.4.6.tar.gz
./configure --prefix=/opt/tengine-1.4.6 --with-jemalloc

cur_path=$(cd "$(dirname "$0")"; pwd)
echo $cur_path

# 1、安装需要的第三方库
yum install pcre-devel openssl-devel zlib-devel -y

src_path="$cur_path/source"
mkdir ${src_path} -p

nginx_version="nginx-1.2.6"
 
# 1、添加 www 用户用来执行nginx
useradd -M -r -s /sbin/nologin -d /opt/${nginx_version}/ www

# 2、创建临时目录
mkdir -p /var/tmp/nginx/client/
mkdir -p /var/tmp/nginx/proxy/
mkdir -p /var/tmp/nginx/fcgi/

# 3、建立虚拟机配置文件存放的目录
mkdir -p /opt/${nginx_version}/conf/sites

# 4、下载nginx最新稳定版源代码
cd ${src_path}/
wget http://nginx.org/download/${nginx_version}.tar.gz

# 5、解压，编译，安装
tar vxzf $src_path/${nginx_version}.tar.gz
cd ${nginx_version}/
           
./configure \
  --prefix=/opt/${nginx_version} \
  --error-log-path=/var/log/nginx/error.log \
  --pid-path=/var/run/nginx/nginx.pid  \
  --lock-path=/var/lock/nginx.lock \
  --user=www \
  --group=www \
  --with-http_ssl_module \
  --with-http_stub_status_module \
  --with-http_gzip_static_module \
  --http-log-path=/var/log/nginx/access.log \
  --http-client-body-temp-path=/var/tmp/nginx/client/ \
  --http-proxy-temp-path=/var/tmp/nginx/proxy/ \
  --http-fastcgi-temp-path=/var/tmp/nginx/fcgi/ \
  --http-uwsgi-temp-path=/var/tmp/nginx/uwsgi/
           
make
make install

# 6、配置nginx
# vim /opt/${nginx_version}/conf/nginx.conf
	
echo "# 指定启动用户" > /opt/${nginx_version}/conf/nginx.conf
echo "user www www;" >> /opt/${nginx_version}/conf/nginx.conf
echo " " >> /opt/${nginx_version}/conf/nginx.conf
echo "# 进程数量，nginx作者认为一个就可以，根据自己的访问量修改" >> /opt/${nginx_version}/conf/nginx.conf
echo "worker_processes  1;"  >> /opt/${nginx_version}/conf/nginx.conf
echo " " >> /opt/${nginx_version}/conf/nginx.conf
echo "# 设置错误日志" >> /opt/${nginx_version}/conf/nginx.conf
echo "#error_log  logs/error.log  notice;" >> /opt/${nginx_version}/conf/nginx.conf
echo "#error_log  logs/error.log  info;" >> /opt/${nginx_version}/conf/nginx.conf
echo "error_log /var/log/nginx/error.default.log;" >> /opt/${nginx_version}/conf/nginx.conf
echo " " >> /opt/${nginx_version}/conf/nginx.conf
echo "pid /var/run/nginx/nginx.pid;" >> /opt/${nginx_version}/conf/nginx.conf
echo " " >> /opt/${nginx_version}/conf/nginx.conf
echo "events {" >> /opt/${nginx_version}/conf/nginx.conf
echo "    use epoll;" >> /opt/${nginx_version}/conf/nginx.conf
echo "    worker_connections  1024;" >> /opt/${nginx_version}/conf/nginx.conf
echo "}" >> /opt/${nginx_version}/conf/nginx.conf
echo " " >> /opt/${nginx_version}/conf/nginx.conf
echo "http {" >> /opt/${nginx_version}/conf/nginx.conf
echo "    charset       utf-8;" >> /opt/${nginx_version}/conf/nginx.conf
echo " " >> /opt/${nginx_version}/conf/nginx.conf
echo "    include       mime.types;" >> /opt/${nginx_version}/conf/nginx.conf
echo "    default_type  application/octet-stream;" >> /opt/${nginx_version}/conf/nginx.conf
echo " " >> /opt/${nginx_version}/conf/nginx.conf
echo "    #log_format  main  '\$remote_addr - \$remote_user [\$time_local] \"\$request\" '" >> /opt/${nginx_version}/conf/nginx.conf
echo "    #                  '\$status \$body_bytes_sent \"\$http_referer\" '" >> /opt/${nginx_version}/conf/nginx.conf
echo "    #                  '\"\$http_user_agent\" \"\$http_x_forwarded_for\"';" >> /opt/${nginx_version}/conf/nginx.conf
echo " " >> /opt/${nginx_version}/conf/nginx.conf
echo "    #access_log  logs/access.log  main;" >> /opt/${nginx_version}/conf/nginx.conf
echo " " >> /opt/${nginx_version}/conf/nginx.conf
echo "    sendfile    on;" >> /opt/${nginx_version}/conf/nginx.conf
echo "    tcp_nopush  on;" >> /opt/${nginx_version}/conf/nginx.conf
echo "    tcp_nodelay on;" >> /opt/${nginx_version}/conf/nginx.conf
echo " " >> /opt/${nginx_version}/conf/nginx.conf
echo "    #keepalive_timeout  0;" >> /opt/${nginx_version}/conf/nginx.conf
echo "    keepalive_timeout  65;" >> /opt/${nginx_version}/conf/nginx.conf
echo "  " >> /opt/${nginx_version}/conf/nginx.conf
echo "    gzip  on;" >> /opt/${nginx_version}/conf/nginx.conf
echo "    gzip_min_length 500;" >> /opt/${nginx_version}/conf/nginx.conf
echo "    gzip_proxied any;" >> /opt/${nginx_version}/conf/nginx.conf
echo "    gzip_types text/plain text/css text/xml" >> /opt/${nginx_version}/conf/nginx.conf
echo "               application/x-javascript application/xml" >> /opt/${nginx_version}/conf/nginx.conf
echo "               application/atom+xml text/javascript;" >> /opt/${nginx_version}/conf/nginx.conf
echo " " >> /opt/${nginx_version}/conf/nginx.conf
echo "    server {" >> /opt/${nginx_version}/conf/nginx.conf
echo "        listen       80;" >> /opt/${nginx_version}/conf/nginx.conf
echo "        server_name  localhost;" >> /opt/${nginx_version}/conf/nginx.conf
echo " " >> /opt/${nginx_version}/conf/nginx.conf
echo "        charset utf-8;" >> /opt/${nginx_version}/conf/nginx.conf
echo " " >> /opt/${nginx_version}/conf/nginx.conf
echo "        #access_log  logs/host.access.log  main;" >> /opt/${nginx_version}/conf/nginx.conf
echo " " >> /opt/${nginx_version}/conf/nginx.conf
echo "        location / {" >> /opt/${nginx_version}/conf/nginx.conf
echo "            root   html;" >> /opt/${nginx_version}/conf/nginx.conf
echo "            index  index.html index.htm;" >> /opt/${nginx_version}/conf/nginx.conf
echo "        }" >> /opt/${nginx_version}/conf/nginx.conf
echo " " >> /opt/${nginx_version}/conf/nginx.conf
echo "        error_page  404              /404.html;" >> /opt/${nginx_version}/conf/nginx.conf
echo " " >> /opt/${nginx_version}/conf/nginx.conf
echo "        error_page   500 502 503 504  /50x.html;" >> /opt/${nginx_version}/conf/nginx.conf
echo "        location = /50x.html {" >> /opt/${nginx_version}/conf/nginx.conf
echo "            root   html;" >> /opt/${nginx_version}/conf/nginx.conf
echo "        }" >> /opt/${nginx_version}/conf/nginx.conf
echo " " >> /opt/${nginx_version}/conf/nginx.conf
echo "    }" >> /opt/${nginx_version}/conf/nginx.conf
echo " " >> /opt/${nginx_version}/conf/nginx.conf
echo "    # 引入虚拟主机文件" >> /opt/${nginx_version}/conf/nginx.conf
echo "    include /opt/${nginx_version}/conf/sites/*.conf;" >> /opt/${nginx_version}/conf/nginx.conf
echo "}" >> /opt/${nginx_version}/conf/nginx.conf

cp $cur_path/config/nginxd /etc/init.d/nginxd
chmod +x /etc/init.d/nginxd
chkconfig --add nginxd
chkconfig nginxd on
