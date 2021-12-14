mkdir work-apache2-inst
cd work-apache2-inst
rm -rf ./*
echo Updating Build Tools / Dists
yum groupinstall "Development Tools" -y
yum install curl make gcc gcc-c++ pcre-devel expat-devel zlib zlib-devel openssl-devel m4 python3-devel -y
echo Downloading httpd-2.4.51
curl -LO https://dlcdn.apache.org/httpd/httpd-2.4.51.tar.gz
tar xvzf httpd-2.4.51.tar.gz

echo Downloading plugins
mkdir plugin
cd plugin
curl -LO https://dlcdn.apache.org//apr/apr-util-1.6.1.tar.gz &
curl -LO https://dlcdn.apache.org//apr/apr-1.7.0.tar.gz
fg

echo Unzipping Plugins
tar xvzf apr-util-1.6.1.tar.gz &
tar xvzf apr-1.7.0.tar.gz

fg

echo Installing Plugins
cd ./apr-1.7.0
./configure --prefix=/usr/local/apache2
make && make install
cd ../apr-util-1.6.1

./configure --with-apr=/usr/local/apache2 --prefix=/usr/local/apache2
make && make install
cd ../../httpd-2.4.51/

echo Installing HTTPD
./configure --prefix=/usr/local/apache2 --enable-module=so --enable-mods-shared=all --enable-so --enable-deflate --enable-rewrite --enable-ssl --with-ssl --with-apr=/usr/local/apache2 --with-apr-util=/usr/local/apache2
make && make install
cd ../

ln -s /usr/local/apache2/bin/httpd /usr/local/bin/httpd
ln -s /usr/local/apache2 /httpd

cd plugin
curl -LO https://github.com/GrahamDumpleton/mod_wsgi/archive/refs/tags/4.9.0.tar.gz
tar xvzf 4.9.0.tar.gz
cd mod_wsgi-4.9.0
./configure --with-apxs=/usr/local/apache2/bin/apxs --with-python=$(which python3)
make && make install
cd ../../
