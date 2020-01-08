# basic config
yum install -y gcc-c++
yum install -y pcre pcre-devel
yum install -y zlib zlib-devel
yum install -y openssl openssl-devel
yum install -y lrzsz

# install
curl -O http://nginx.org/download/nginx-1.17.7.tar.gz
tar -zxvf nginx-1.17.7.tar.gz
mv nginx-1.17.7 /usr/local
ln -s nginx-1.17.7 nginx
./configure
make & make install
mkdir logs

# start & stop
#!/bin/sh
/usr/local/nginx/sbin/nginx           # start  
/usr/local/nginx/sbin/nginx -t        # test config
/usr/local/nginx/sbin/nginx -v        # show version
/usr/local/nginx/sbin/nginx -s stop   # fast stop
/usr/local/nginx/sbin/nginx -s quit   # normal stop
/usr/local/nginx/sbin/nginx -s reload # restart

# firewall
# firewall-cmd --zone=public --add-port=80/tcp --permanent
# firewall-cmd --reload
