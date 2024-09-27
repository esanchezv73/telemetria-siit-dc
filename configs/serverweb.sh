apk add openrc 
sleep 1
apk add apache2
#apk add nginx
sleep 1
apk add openssl
sleep 1
touch /run/openrc/softlevel
sleep 1
#/etc/rc.d/apache2 stop
#/etc/init.d/nginx stop
#/usr/sbin/httpd
# Crear un directorio para los certificados SSL
mkdir -p /etc/apache2/ssl

# Generar un certificado SSL auto-firmado
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/apache2/ssl/apache.key \
  -out /etc/apache2/ssl/apache.crt \
  -subj "/C=AR/ST=Salta/L=Salta/O=Ucasal/OU=Unit/CN=dominio.com"
