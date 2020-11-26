<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://www.overtel.com">
    <img src="images/overtel-logo.png" alt="Logo Overtel" width="30%" height="30%">
  </a>
  <a href="https://pandorafms.com/">
    <img src="images/pandorafms-logo.png" alt="Logo PandoraFMS" width="30%" height="30%">
  </a>
  <a href="https://www.microsoft.com/">
    <img src="images/microsoft-logo.jpg" alt="Logo Microsoft" width="30%" height="30%">
  </a>
  

  <h3 align="center">Monitorización básica de Windows con PandoraFMS</h3>

  <p align="center">
    Conjunto de scripts que nos permite extraer datos basicos mediante consultas WMI, de uso de CPU, Memoria física y virtual, Rendimiento de discos, Rendimiento de tarjetas de red así como paquetes con error.<br>
	Todo mediante el uso de scripts VBS
    <br />
    <a href="https://github.com/franciscotudel-overtel/pandorafms_basic_windows_monitornig/issues">Reportar un Bug</a>
    ·
    <a href="https://github.com/franciscotudel-overtel/pandorafms_basic_windows_monitornig/issues">Requerir una nueva caracteristica</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
## Tabla de contenido

* [Acerca de nosotros](#Acerca-de-nosotros)
* [Comenzando](#Comenzando)
  * [Prerequisitos](#Prerequisitos)
  * [Instalacion](#Instalacion)
* [Ejemplos de uso](#Ejemplos-de-uso)
  * [Recoger todo de golpe](#Recoger-Todo-de-Golpe)
  * [Recoger modulos por separado](#Recoger-modulos-por-separado)
* [Contribuir](#contribuir)
* [Licencia](#licencia)
* [Contacto](#contacto)
* [Agradecimientos](#agradecimientos)



<!-- Sobre el proyecto -->
## Acerca de Nosotros
*Overtel Technology Systems* se dedicada al desarrollo y la implementación de Nuevas Tecnologías de la Información y Comunicaciones (TIC), aparece en el panorama nacional en mayo de 1996, abriendo su primer centro de trabajo en Cartagena (Región de Murcia) donde a día de hoy ubica su central de recursos y oficinas administrativas, siendo el epicentro de su constante expansión hacia otras provincias de España, principalmente el levante Español, Murcia, Almería, Alicante, Valencia…
Operando con un equipo de calidad humana y técnica sobresaliente, damos servicio a toda la geografía nacional.

*Pandora FMS* es un software de código abierto que sirve para monitorear (monitorizar) y medir todo tipo de elementos. Monitoriza sistemas, aplicaciones o dispositivos de red. Permite conocer el estado de cada elemento de un sistema a lo largo del tiempo ya que dispone de histórico de datos y eventos. Pandora FMS está orientado a grandes entornos, y permite gestionar con y sin agentes, varios miles de sistemas, por lo que se puede emplear en grandes clusters, centros de datos y redes de todo tipo.

La recogida de los datos se lleva a cabo por medio de scripts vbs que se encargan de hacer las consultas WMI y convertirlas en modulos reconocibles por PANDORAFMS


<!-- COMENZANDO -->
## Comenzando
### Prerequisitos

* El agente de PandoraFMS debe estar instalado y ser funcional.

### Instalacion

1. Clonar el repositorio en la carpeta de scripts de pandorafms. Desde una linea de comandos (Tecla Win + R) ... cmd + Enter
```sh
cd c:\
cd pandorafms
mkdir scripts
cd scripts
git clone https://github.com/franciscotudel-overtel/pandorafms_basic_windows_monitornig
```

2. Comenzar a poner plugins de agente, para ello podemos seguir el manual del fabricate [aqui][plugins-agente] o editar directamente el fichero pandora_agent.conf que estará en la carpeta de instalación del agente. 

Por ejemplo el plugin que devuelve el uptime y la hora local se configura simplemente así:
```
module_plugin cscript.exe //B "%PROGRAMFILES%\Pandora_Agent\util\system_uptime.vbs" //nologo
```


<!-- USAGE EXAMPLES -->
## Ejemplos de uso

A partir de aqui detallo todos los plugins

Simplemente para recordar, En la Wiki de pandorafms, [aqui](https://pandorafms.com/docs/index.php?title=Pandora:Documentation_es:Configuracion_Agentes#module_type_.3Ctipo.3E) en la sección 1.6.1.3 se detalla los tipos de modulos que pueden ser usados en un agente.

- *Numérico* (generic_data): Datos numéricos sencillos, con coma flotante o enteros.
- *Incremental* (generic_data_inc): Dato numérico igual a la diferencia entre el valor actual y el valor anterior dividida por el número de segundos transcurridos. Cuando esta diferencia es negativa, se reinicia el valor, esto significa que cuando la diferencia vuelva a ser positiva de nuevo se tomará el valor anterior siempre que el incremento vuelva a dar un valor positivo.
- *Absolute incremental* (generic_data_inc_abs): Dato numérico igual a la diferencia entre el valor actual y el valor anterior, sin realizar la división entre el número de segundos transcurridos, para medir incremento total en lugar de incremento por segundo. Cuando esta diferencia es negativa, se reinicia el valor, esto significa que cuando la diferencia de nuevo vuelva a ser positiva, se empleará el último valor desde el que el actual incremento obtenido da positivo.
- *Alfanumérico* (generic_data_string): Recoge cadenas de texto alfanuméricas.
- *Booleanos* (generic_proc): Para valores que solo pueden ser correcto o afirmativo (1) o incorrecto o negativo (0). Útil para comprobar si un equipo está vivo, o un proceso o servicio está corriendo. Un valor negativo (0) trae preasignado el estado crítico, mientras que cualquier valor superior se considerará correcto.
- *Alfanumérico asíncrono* (async_string): Para cadenas de texto de tipo asíncrono. La monitorización asíncrona depende de eventos o cambios que pueden ocurrir o no, por lo que este tipo de módulos nunca están en estado desconocido.
- *Booleano asíncrono* (async_proc): Para valores booleanos de tipo asíncrono.
- *Numérico asíncrono* (async_data): Para valores numéricos de tipo asíncrono.


## Recoger Todo de Golpe

### Todas las medidas
*Descripción*:
Obtener telemetria de todos los plugins contenidos aqui.<br>
Dentro del Script es posible habilitar más medidas si se cree necesario.<br>
*Dato Devuelto*:
Devuelve un *string*.<br>

```
module_plugin "%PROGRAMFILES%\Pandora_Agent\util\basic_monitoring_all_modules.cmd"
```

## Recoger modulos por separado

### Logical Disk
*Descripción*:
Obtener medidas de tiempos y uso de discos logicos.<br>
Dentro del Script es posible habilitar más medidas si se cree necesario.<br>
*Dato Devuelto*:
Devuelve un *entero*.<br>

```
module_plugin cscript.exe //B "%PROGRAMFILES%\Pandora_Agent\util\disk_perfomance_logical_disk.vbs" //nologo
```

### Physical Disk
*Descripción*:
Obtener medidas de tiempos y uso de discos físicos.<br>
Dentro del Script es posible habilitar más medidas si se cree necesario.<br>
*Dato Devuelto*:
Devuelve un *entero*.<br>

```
module_plugin cscript.exe //B "%PROGRAMFILES%\Pandora_Agent\util\disk_perfomance_physical_disk.vbs" //nologo
```

### Disk usage with total
*Descripción*:
Obtener medidas de porcentage libre en disco duro CON tamaño total del mismo en cada nombre de modulo.<br>
Facilita y aclara la visualización de las gráficas, ya que en la etiqueta esta el tamaño.<br>
*Dato Devuelto*:
Devuelve un *entero*.<br>

```
module_plugin cscript.exe //B "%PROGRAMFILES%\Pandora_Agent\util\disk_usage_with_total.vbs" //nologo
```

### CPU
*Descripción*:
Obtener medidas de tiempos y uso de CPU.<br>
*Dato Devuelto*:
Devuelve un *entero*.<br>

```
module_plugin module_plugin cscript.exe //B "%PROGRAMFILES%\Pandora_Agent\util\cpu_usage.vbs" //nologo
```

### Network Interfaces
*Descripción*:
Obtener Velocidades en envio y recepcion, errores y velocidad del enlace de todas las tarjetas de red.<br>
*Dato Devuelto*:
Devuelve un *entero*.<br>

```
module_plugin module_plugin cscript.exe //B "%PROGRAMFILES%\Pandora_Agent\util\interfaces.vbs" //nologo
```

### Physical Memory
*Descripción*:
Obtener Total, usado y libre y tantos por ciento % de la memoria física.
*Dato Devuelto*:
Devuelve un *entero*.<br>

```
module_plugin module_plugin cscript.exe //B "%PROGRAMFILES%\Pandora_Agent\util\physical_memory.vbs" //nologo
```

### Virtual Memory
*Descripción*:
Obtener Total, usado y libre y tantos por ciento % de la memoria virtual.
*Dato Devuelto*:
Devuelve un *entero*.<br>

```
module_plugin module_plugin cscript.exe //B "%PROGRAMFILES%\Pandora_Agent\util\virtual_memory.vbs" //nologo
```

### Uptime
*Descripción*:
Obtener Segundos desde el último reinicio, Fecha y hora del último reinicio y Fecha y hora local (con el desfase del tiempo de muestreo, por defecto 5 minutos)
*Dato Devuelto*:
Devuelve un *string*.<br>

```
module_plugin module_plugin cscript.exe //B "%PROGRAMFILES%\Pandora_Agent\util\system_uptime.vbs" //nologo
```

<!-- LICENCIA -->
## Licencia

Distribuido con the GNU General Public License v3.0. Ver `LICENSE` para mas informacion.



<!-- CONTACTO -->
## Contacto

- Project Link: [https://github.com/franciscotudel-overtel/pandorafms_basic_windows_monitornig](https://github.com/franciscotudel-overtel/pandorafms_basic_windows_monitornig)
- LinkedIn: [LinkedIn][linkedin-url]

<!-- AGRADECIMIENTOS -->
## Agradecimientos
* [Wikipedia - Que es IPMI](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/franciscotudel-overtel/pandorafms_basic_windows_monitornig.svg?style=flat-square
[contributors-url]: https://github.com/franciscotudel-overtel/pandorafms_basic_windows_monitornig/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/francisco-tudel-escalona-44076069/pandorafms_basic_windows_monitornig.svg?style=flat-square
[forks-url]: https://github.com/franciscotudel-overtel/pandorafms_basic_windows_monitornig/network/members
[stars-shield]: https://img.shields.io/github/stars/francisco-tudel-escalona-44076069/pandorafms_basic_windows_monitornig.svg?style=flat-square
[stars-url]: https://github.com/franciscotudel-overtel/pandorafms_basic_windows_monitornig/stargazers
[issues-shield]: https://img.shields.io/github/issues/francisco-tudel-escalona-44076069/pandorafms_basic_windows_monitornig.svg?style=flat-square
[issues-url]: https://github.com/franciscotudel-overtel/pandorafms_basic_windows_monitornig/issues
[license-shield]: https://img.shields.io/github/license/francisco-tudel-escalona-44076069/pandorafms_basic_windows_monitornig.svg?style=flat-square
[license-url]: https://github.com/franciscotudel-overtel/pandorafms_basic_windows_monitornig/blob/main/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/francisco-tudel-escalona-44076069
[plugins-fms]: https://pandorafms.com/es/pandora-extensiones/
[plugins-agente]: https://pandorafms.com/docs/index.php?title=Pandora:Documentation_es:Anexo_Agent_Plugins

