mkdir work-apache2-inst
cd work-apache2-inst
rm -rf ./*
echo Updating Build Tools / Dists
yum groupinstall "Development Tools" -y
yum install curl make gcc gcc-c++ pcre-devel expat-devel zlib zlib-devel openssl-devel m4 -y
echo Downloading httpd-2.4.43
curl -LO http://archive.apache.org/dist/httpd/httpd-2.4.43.tar.gz
tar xvzf httpd-2.4.43.tar.gz

echo Downloading plugins
mkdir plugin
cd plugin
curl -LO https://ftp.pcre.org/pub/pcre/pcre2-10.35.tar.gz &
curl -LO http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz &
curl -LO http://ftp.gnu.org/gnu/automake/automake-1.15.tar.gz &
curl -LO http://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.gz &
curl -LO http://apache.tt.co.kr//apr/apr-1.7.0.tar.gz &
curl -LO http://apache.tt.co.kr//apr/apr-util-1.6.1.tar.gz &
curl -LO http://mirror.jre655.com/GNU/libtool/libtool-2.4.6.tar.gz &
curl -LO http://apache.tt.co.kr//apr/apr-1.7.0.tar.gz
sleep 2

fg
fg
fg
fg
fg
fg

echo Unzipping Plugins
tar xvzf libtool-2.4.6.tar.gz &
tar xvzf m4-1.4.18.tar.gz &
tar xvzf pcre2-10.35.tar.gz &
tar xvzf autoconf-2.69.tar.gz &
tar xvzf apr-util-1.6.1.tar.gz &
tar xvzf automake-1.15.tar.gz &
tar xvzf apr-1.7.0.tar.gz
sleep 2

fg
fg
fg
fg
fg
fg
fg

echo Installing Plugins
cd ./apr-1.7.0
./configure --prefix=/usr/local/apache/apr
make && make install
cd ../apr-util-1.6.1

./configure --with-apr=/usr/local/apache/apr --prefix=/usr/local/apache/apr-util
make && make install
cd ../pcre2-10.35

./configure
make && make install
cd ../libtool-2.4.6

./configure
make && make install
cd ../m4-1.4.18

./configure
make && make install
cd ../autoconf-2.69

./configure
make && make install
cd ../automake-1.15

./configure
make && make install
cd ../../httpd-2.4.43/

echo Installing HTTPD
./configure --prefix=/usr/local/apache24 --enable-module=so --enable-mods-shared=all --enable-so --enable-deflate --enable-rewrite --enable-ssl --with-ssl --with-apr=/usr/local/apache/apr --with-apr-util=/usr/local/apache/apr-util
make && make install
cd ../

ln -s /usr/local/apache24/bin/httpd /usr/local/bin/httpd