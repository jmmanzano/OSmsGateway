<!-- start project-info -->
<!--
project_title: OSmsGateway
github_project: https://github.com/jmmanzano/OSmsGateway
license: GPL
homepage: https://github.com/jmmanzano/OSmsGateway
license-badge: True
contributors-badge: False
lastcommit-badge: True
codefactor-badge: False
--->

<!-- end project-info -->

<!-- start badges -->

![License GPL](https://img.shields.io/badge/license-GPL-green)
![Contributors](https://img.shields.io/github/contributors-anon/jmmanzano/OSmsGateway)
![Last commit](https://img.shields.io/github/last-commit/jmmanzano/OSmsGateway)

<!-- end badges -->

<!-- start description -->

# OSmsGateway

## Descripción

OpensourceSmsGateway es una aplicación escrita en flutter que permite crear una API REST en tu teléfono móvil para el envío de SMS.

Intenta mantener la compatibilidad con REST SMS Gateway.

### Permite configurar HTTPS con certificados de Let's Encrypt.

![Configuracion](https://github.com/jmmanzano/OSmsGateway/blob/main/imgs/conf.png?raw=true)

- Server chain -> fullchain.pem

- Server key -> privkey.pem

### Envío desde web.

En la raíz del servidor cuenta con una interfaz para el envío de SMS.
![Imagen envio web](https://github.com/jmmanzano/OSmsGateway/blob/main/imgs/send_page.png?raw=true)

### Tema claro (por defecto) y tema oscuro

![Tema Claro](https://github.com/jmmanzano/OSmsGateway/blob/main/imgs/claro.png?raw=true)

![Tema Oscuro](https://github.com/jmmanzano/OSmsGateway/blob/main/imgs/oscuro.png?raw=true)

Su nivel de madurez actual es bajo.

<!-- end description -->

<!-- start prerequisites -->

<!-- end prerequisites -->

<!-- start installing -->

## Instalación

Puedes descargar el proyecto y construir tu propio APK con Android Studio.

También puedes descargar el apk ya construido desde [aquí](https://github.com/jmmanzano/OSmsGateway/releases)

Requiere permisos para LEER y ENVIAR SMS y para conocer el ESTADO DEL TELÉFONO.

<!-- end installing -->

<!-- start using -->

## Uso

Al mantener la compatibilidad con REST SMS Gateway puedes enviar SMS mediante métodos POST y GET:

- curl -X "POST" "http://192.168.1.51:8080/v1/sms/?phone=987654321&message=your%20message"
- curl -X "GET" "http://192.168.1.51:8080/v1/sms/send/?phone=987654321&message=your%20message"

Se está implementando la parte de estatus, pero no es ni completa ni mantiene aún la compatibilidad con REST SMS Gateway

<!-- end using -->

<!-- start contributing -->

<!-- end contributing -->

<!-- start contributors -->

<!-- end contributors -->

<!-- start table-contributors -->

<table id="contributors">
	<tr id="info_avatar">
		<td id="jmmanzano" align="center">
			<a href="https://github.com/jmmanzano">
				<img src="" width="100px"/>
			</a>
		</td>
	</tr>
	<tr id="info_name">
		<td id="jmmanzano" align="center">
			<a href="https://github.com/jmmanzano">
				<strong></strong>
			</a>
		</td>
	</tr>
	<tr id="info_commit">
		<td id="jmmanzano" align="center">
			<a href="/commits?author=jmmanzano">
				<span id="role">💻</span>
			</a>
		</td>
	</tr>
</table>
<!-- end table-contributors -->
