#$status = "Automatic"
$status = "Disable"


## Administracion de maquinas remotas 
Set-Service -StartupType $status WinRM

## 
Set-Service -StartupType $status MapsBroker

## Administracion de conexiones de red
Set-Service -StartupType $status NcbService

## Acceso remoto
Set-Service -StartupType $status RemoteAccess

## 
Set-Service -StartupType $status RmSvc

## Diagnostico del sistema
Set-Service -StartupType $status DPS

##
Set-Service -StartupType $status InstallService

## 
Set-Service -StartupType $status TermService

## Recursos compartidos de red con protocolo SMB 
Set-Service -StartupType $status LanmanServer

## Temas
Set-Service -StartupType $status Themes

## 
Set-Service -StartupType $status DusmSvc

## Administracion de dispositivos de interfaz humana como teclados y ratones
Set-Service -StartupType $status hidserv

## Precarga de aplicaciones
Set-Service -StartupType $status SysMain

## Impresion
Set-Service -StartupType $status Spooler

## Acceso a recursos compartidos en una red
Set-Service -StartupType $status LanmanWorkstation

## Audio Bluetooth
Set-Service -StartupType $status BthAvctpSvc

## Panel de control Nvidia
Set-Service -StartupType $status NVDisplay.ContainerLocalSystem

## Iluminacion Logitech
Set-Service -StartupType $status logi_lamparray_service 

## Acceso a servidores remotos por VPN y SSTP 
Set-Service -StartupType $status SstpSvc

## Administra conexiones de acceso telefonico y VPN desde el equipo a Internet u otras redes remotas
Set-Service -StartupType $status RasMan 

## Detección SSDP: Facilita el descubrimiento y configuración automática de dispositivos en una red local
Set-Service -StartupType $status SSDPSRV

## Aplicación auxiliar de Netbios sobre TCP/IP: Da compatibilidad a aplicaciones que dependen del protocolo NetBios
Set-Service -StartupType $status lmhosts

## Cliente de seguimiento de vínculos distribuidos: Permite mantener la integridad de los enlaces a archivos y carpetas en una RED
Set-Service -StartupType $status TrkWks

## Servicio de detección automática de proxy web WinHTTP: Automatiza la configuración y el uso de servidores proxy
Set-Service -StartupType $status WinHttpAutoProxySvc

## Servicio del sistema de notificación de inserción de Windows: Maneja las notificación push en Windows
Set-Service -StartupType $status WpnService



