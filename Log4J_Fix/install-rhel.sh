mkdir work-apache2-inst
cd work-apache2-inst
apt install make gcc g++ libpcre3-dev libexpat1-dev build-essential zlib1g zlib1g-dev openssl m4 python3-dev gnulib curl -y
echo Downloading httpd-2.4.52
curl -LO https://dlcdn.apache.org/httpd/httpd-2.4.52.tar.gz
tar xvzf httpd-2.4.52.tar.gz

cd httpd-2.4.52/
./configure --prefix=/usr/local/apache2 --enable-module=so --enable-mods-shared=all --enable-so --enable-deflate --enable-rewrite --enable-ssl --with-ssl=/usr/local/openssl-1.1.1g --with-apr=/usr/local/apache2 --with-apr-util=/usr/local/apache2
make && make install
cd ../../