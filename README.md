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
Comprobar acceso al servidor web ejecutando solicitud HTTP: `wget http://192.168.0.80`
#### Acceso al Dashboard Grafana
* Desde navegador en host local a la url: `http://ip-hostlocal:3000`
## Ejemplos ataques
### Flooding tool. From https://www.kali.org/tools/t50/
>***atk6-flood_advertise6:** Flood the target /64 network with ICMPv6 NA messages random IPv6 link local address.
* Desde **PC1**
  *  Lanzar el ataque ejecutando: `atk6-flood_advertise6 eth1`
  *  Ataque mitigado por ACL IPv6 bindings permitidos. Visualización en Dashboard Matched Packets por ACL Entry.
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


