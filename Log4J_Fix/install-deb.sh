mkdir work-apache2-inst
cd work-apache2-inst
yum install curl make gcc gcc-c++ pcre-devel expat-devel zlib zlib-devel openssl-devel m4 python3-devel -y
echo Downloading httpd-2.4.51
curl -LO https://dlcdn.apache.org/httpd/httpd-2.4.51.tar.gz
tar xvzf httpd-2.4.51.tar.gz

cd httpd-2.4.51/
./configure --prefix=/usr/local/apache2 --enable-module=so --enable-mods-shared=all --enable-so --enable-deflate --enable-rewrite --enable-ssl --with-ssl --with-apr=/usr/local/apache2/ --with-apr-util=/usr/local/apache2/
make && make install
cd ../../