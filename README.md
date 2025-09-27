# Stack de Telemetría en un entorno SIIT-DC con Containerlab
  
## Descripción
La siguiente topología integra un servidor SIIT-DC Jool a Containerlab, y un Stack de Telemetría que permitirá realizar pruebas basadas en IPv4/IPv6 Translation

## Requerimientos de software y SO

Para desplegar la topología propuesta debe disponer de:

* Dispositivo Host con Containerlab instalado:
* Sistema Operativo Linux "Ubuntu 22.04.3 LTS". Kernel headers 5.15.0-116-generic
* Docker Engine - Community Version: 24.0.7
* Containerlab version: 0.56.0

## Instalación de los archivos de topología
```console
root@server:../git clone https://github.com/ernestosv73/siitdc2.git
```
## Deploy de la topología
```console
root@server:../siitdc2#clab deploy -t siitdc.yml
```
## Acceso a los nodos

```console
root@server:../siitdc2#docker exec -it clab-siitdc2-SRVSIIT /bin/bash
root@server:../siitdc2#docker exec -it clab-siitdc2-SRV1 /bin/bash
root@server:../siitdc2#docker exec -it clab-siitdc2-PC1 /bin/bash
root@server:../siitdc2#docker exec -it clab-siitdc2-PC2 /bin/bash
```
## Descripción del ejemplo de prueba 
### Topología creada
![Alt text](images/toposiitdc.png)

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


