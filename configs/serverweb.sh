apk add openrc 
sleep 1
#apk add apache2
apk add nginx
sleep 1
apk add openssl
touch /run/openrc/softlevel
sleep 1
/etc/rc.d/apache2 stop
/etc/init.d/nginx stop
/usr/sbin/httpd
