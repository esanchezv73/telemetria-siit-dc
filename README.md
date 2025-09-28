# Stack de Telemetría en un entorno SIIT-DC con Containerlab
  
## Descripción
La topología creada provee un laboratorio de pruebas para el análisis de seguridad mediante un Stack de Telemetría en un entorno de red IPv4/IPv6 basado en SIIT-DC 
### Topología creada
![Alt text](images/red.png)

## Descripción Stack de Telemetría
Permite suscripción a métricas ACLs match packets, broadcast packets y consumo de CPU recibidas desde un dispositivo Nokia SRL vía gNMI. 
* Nodo colector gNMIc Openconfig, recibe y exporta a Stack Prometheus/Grafana  

``
## Deploy de la topología
```console
clab deploy -t tele-siitdc.yml
```
## Acceso a los nodos
#### Nodo gNMIc
```console
docker exec -it clab-telemetria-siitdc-gNMIc /bin/bash
```
suscripción a métricas, ejecutar: `gnmic subscribe --config /gnmic-config.yml`
#### Servidor web
```console
docker exec -it clab-telemetria-siitdc-webserver /bin/bash
```
Iniciar servidor ejecutando `nginx`
#### PCs Linux
```console
docker exec -it clab-telemetria-siitdc-PC2 /bin/bash
docker exec -it clab-telemetria-siitdc-PC3 /bin/bash
```
Eliminar ruta por defecto en eth0: `ip route del default dev eth0` y ejecutar cliente dhcp con `dhclient eth1`




### Descripción de Contenedores
* Contenedor Srl1: dispositivo Switch
* Contenedor SRVSIIT: image docker Ubuntu 22.04. Jool version 4.2.0-rc2
* Contenedor SRV1: image docker Ubuntu 22.04
* Contenedor PC1 y PC2: image docker Alpine Linux
* El detalle las configuraciones de red se encuentran en el archivo .yml

### Descripción del ejemplo de prueba: Explicit Address Mappings Table - EAMT

* El siguiente ejemplo muestra un caso de implementación de un servidor Jool en modo SIIT para permitir conexión de un cliente IPv4 a un Servidor IPv6 a nivel de capa 3:
* Desde el contenedor SRVSIIT ejecutar los siguientes comandos:
```console
root@SRVSIIT:/#modprobe jool_siit
root@SRVSIIT:/#jool_siit instance add "lacnic" --netfilter --pool6 64:ff9b::/96
root@SRVSIIT:/#jool_siit -i "lacnic" eamt add 192.168.0.80/32 2001:db8:dc::50/128
```
* Desde el contenedor PC2 probar que se tiene conectividad al servidor SRV1 ejecutando:
```console
PC2:/#ping 192.168.0.80
```
## Notas
* La versión de Jool instalada en el contenedor SRVSIIT soporta los modos SIIT, Stateful NAT64 and MAP-T.
  
## Referencias
* https://containerlab.dev/
* https://www.jool.mx/en/eamt.html
* https://www.jool.mx/en/run-eam.html

## Author

MSc. Ernesto Sánchez. 

mail: esanchez@ucasal.edu.ar

linkedin: https://www.linkedin.com/in/ernestos%C3%A1nchez


## License

This project is licensed under the [MIT] License - see the LICENSE.txt file for details


