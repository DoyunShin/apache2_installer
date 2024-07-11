if [ -f /etc/redhat-release ]; then
    echo "Starting for RHEL system"
elif [ -f /etc/debian_version ]; then
    echo "Starting for Debian system"
else
    echo "Unsupported OS"
    exit 1
fi

THREADS=$(nproc)

MOD_WSGI=1

APACHE_VERSION=2.4.61
APR_VERSION=1.7.4
APR_UTIL_VERSION=1.6.3
MOD_WSGI_VERSION=5.0.0

mkdir work-apache2-inst
cd work-apache2-inst
rm -rf ./*
echo Updating Build Tools / Dists
if [ -f /etc/redhat-release ]; then
    yum groupinstall "Development Tools" -y
    yum install curl make gcc gcc-c++ pcre-devel expat-devel zlib zlib-devel openssl-devel m4 -y
    
    if grep -q "8" /etc/redhat-release; then
        yum install -y python39-devel
    else
        yum install -y python3-devel
    fi

elif [ -f /etc/debian_version ]; then
    apt update
    apt install make gcc g++ libpcre3-dev libexpat1-dev build-essential zlib1g zlib1g-dev openssl m4 python3-dev gnulib curl libssl-dev -y
fi


echo Downloading httpd-$APACHE_VERSION
curl -L https://dlcdn.apache.org/httpd/httpd-$APACHE_VERSION.tar.gz | tar xvz

echo Downloading plugins
mkdir plugin
cd plugin

curl -L https://dlcdn.apache.org//apr/apr-$APR_VERSION.tar.gz | tar xvz
curl -L https://dlcdn.apache.org//apr/apr-util-$APR_UTIL_VERSION.tar.gz | tar xvz

echo Installing Plugins
cd ./apr-$APR_VERSION
./configure --prefix=/usr/local/apache2
make -j $THREADS && make install -j $THREADS
cd ../apr-util-$APR_UTIL_VERSION

./configure --with-apr=/usr/local/apache2 --prefix=/usr/local/apache2
make -j $THREADS && make install -j $THREADS
cd ../../httpd-$APACHE_VERSION

echo Installing HTTPD
./configure --prefix=/usr/local/apache2 --enable-module=so --enable-mods-shared=all --enable-so --enable-deflate --enable-rewrite --enable-ssl --with-ssl --with-apr=/usr/local/apache2 --with-apr-util=/usr/local/apache2
make -j $THREADS && make install -j $THREADS
cd ../

ln -s /usr/local/apache2/bin/httpd /usr/local/bin/httpd
ln -s /usr/local/apache2 /httpd
mv /usr/local/apache2/htdocs /var/www
ln -s /var/www /usr/local/apache2/htdocs


if [ $MOD_WSGI -eq 1 ]; then
    echo Installing mod_wsgi
    cd plugin
    curl -L https://github.com/GrahamDumpleton/mod_wsgi/archive/refs/tags/$MOD_WSGI_VERSION.tar.gz | tar xvz
    cd mod_wsgi-$MOD_WSGI_VERSION
    if grep -q "8" /etc/redhat-release; then
        ./configure --with-apxs=/usr/local/apache2/bin/apxs --with-python=$(which python39)
    else
        ./configure --with-apxs=/usr/local/apache2/bin/apxs --with-python=$(which python3)
    fi
    make -j $THREADS && make install -j $THREADS
    cd ../../
fi

