mkdir work-apache2-inst
cd work-apache2-inst
rm -rf ./*
apt update
apt install make gcc g++ libpcre3-dev libexpat1-dev build-essential zlib1g zlib1g-dev openssl m4 python3-dev gnulib curl -y

echo Downloading httpd-2.4.52
curl -LO https://dlcdn.apache.org/httpd/httpd-2.4.52.tar.gz
tar xvzf httpd-2.4.52.tar.gz

mkdir plugin
cd plugin
curl -LO https://ftp.pcre.org/pub/pcre/pcre2-10.35.tar.gz &
curl -LO http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz &
curl -LO http://ftp.gnu.org/gnu/automake/automake-1.15.tar.gz &
curl -LO http://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.gz &
curl -LO https://www.openssl.org/source/openssl-1.1.1g.tar.gz &
curl -LO http://mirror.jre655.com/GNU/libtool/libtool-2.4.6.tar.gz &
curl -LO https://dlcdn.apache.org//apr/apr-util-1.6.1.tar.gz &
curl -LO https://dlcdn.apache.org//apr/apr-1.7.0.tar.gz

fg
fg
fg
fg
fg
fg
fg

tar xvzf openssl-1.1.1g.tar.gz &
tar xvzf libtool-2.4.6.tar.gz &
tar xvzf m4-1.4.18.tar.gz &
tar xvzf pcre2-10.35.tar.gz &
tar xvzf autoconf-2.69.tar.gz &
tar xvzf apr-util-1.6.1.tar.gz &
tar xvzf automake-1.15.tar.gz &
tar xvzf apr-1.7.0.tar.gz 

fg
fg
fg
fg
fg
fg
fg

cd ./apr-1.7.0
./configure --prefix=/usr/local/apache2
make && make install
cd ../apr-util-1.6.1

./configure --with-apr=/usr/local/apache2 --prefix=/usr/local/apache2
make && make install
cd ../openssl-1.1.1g

./config --openssldir=/usr/local/openssl-1.1.1g
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
cd ../../httpd-2.4.52/

./configure --prefix=/usr/local/apache2 --enable-module=so --enable-mods-shared=all --enable-so --enable-deflate --enable-rewrite --enable-ssl --with-ssl=/usr/local/openssl-1.1.1g --with-apr=/usr/local/apache2 --with-apr-util=/usr/local/apache2
make && make install
cd ../

ln -s /usr/local/apache24/bin/httpd /usr/local/bin/httpd
ln -s /usr/local/apache2 /httpd
mv /usr/local/apache2/htdocs /var/www
ln -s /var/www /usr/local/apache2/htdocs


cd plugin
curl -LO https://github.com/GrahamDumpleton/mod_wsgi/archive/refs/tags/4.9.0.tar.gz
tar xvzf 4.9.0.tar.gz
cd mod_wsgi-4.9.0
./configure --with-apxs=/usr/local/apache2/bin/apxs --with-python=$(which python3)
make && make install
cd ../../
