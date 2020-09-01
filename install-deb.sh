mkdir work-apache2-inst
cd work-apache2-inst
rm -rf ./*
apt update
apt install make gcc g++ libpcre3-dev libexpat1-dev build-essential zlib1g zlib1g-dev openssl m4 python3-dev -y
curl -LO http://archive.apache.org/dist/httpd/httpd-2.4.43.tar.gz
tar xvzf httpd-2.4.43.tar.gz
mkdir plugin
cd plugin
curl -LO https://ftp.pcre.org/pub/pcre/pcre2-10.35.tar.gz & > /dev/null
curl -LO http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz & > /dev/null
curl -LO http://ftp.gnu.org/gnu/automake/automake-1.15.tar.gz & > /dev/null
curl -LO http://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.gz & > /dev/null
curl -LO https://www.openssl.org/source/openssl-1.1.1g.tar.gz & > /dev/null
curl -LO http://apache.tt.co.kr//apr/apr-1.7.0.tar.gz & > /dev/null
curl -LO http://apache.tt.co.kr//apr/apr-util-1.6.1.tar.gz & > /dev/null
curl -LO http://mirror.jre655.com/GNU/libtool/libtool-2.4.6.tar.gz
fg > /dev/null
fg > /dev/null
fg > /dev/null
fg > /dev/null
fg > /dev/null
fg > /dev/null
fg > /dev/null
tar xvzf openssl-1.1.1g.tar.gz &
tar xvzf libtool-2.4.6.tar.gz &
tar xvzf m4-1.4.18.tar.gz &
tar xvzf pcre2-10.35.tar.gz &
tar xvzf autoconf-2.69.tar.gz &
tar xvzf apr-1.7.0.tar.gz &
tar xvzf apr-util-1.6.1.tar.gz &
tar xvzf automake-1.15.tar.gz

fg > /dev/null
fg > /dev/null
fg > /dev/null
fg > /dev/null
fg > /dev/null
fg > /dev/null
fg > /dev/null

cd ./apr-1.7.0
./configure --prefix=/usr/local/apache/apr
make && make install
cd ../apr-util-1.6.1

./configure --with-apr=/usr/local/apache/apr --prefix=/usr/local/apache/apr-util
make && make install
cd ../openssl-1.1.1g

./config --openssldir=/usr/local/openssl-1.0.1g
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

./configure --prefix=/usr/local/apache24 --enable-module=so --enable-mods-shared=all --enable-so --enable-deflate --enable-rewrite --enable-ssl --with-ssl=/usr/local/openssl-1.0.1g --with-apr=/usr/local/apache/apr --with-apr-util=/usr/local/apache/apr-util
make && make install
cd ../

ln -s /usr/local/apache24/bin/httpd /usr/local/bin/httpd

cd plugin
curl -LO https://github.com/GrahamDumpleton/mod_wsgi/archive/4.7.1.tar.gz
tar xvzf 4.7.1.tar.gz
cd mod_wsgi-4.7.1
./configure --with-apxs=/usr/local/apache24/bin/apxs --with-python=$(which python3)
make && make install
cd ../../
