# MaaS
Challenge para recorrido.cl

## Contenidos
1. [Información General](#general-info)
2. [Tecnologias](#tecnologias)
3. [Instalación](#instalacion)
4. [Estructura](#estructura)
5. [Credenciales](#credenciales)
6. [Licencia](#licencia)


### Información General
Software que permite coordinar y asignar los turnos de guardia de monitoreo de manera automatica y equitativa entre todos los miembros del equipo.
Mediante la creacion de contratos por parte del administrador según las especificaciones de cada cliente, se le habilitara a cada usuario con el rol de dev una agenda con los horarios para cada contrato para que se inscriba como disponible para cubrir el turno que luego seran asignados de manera automática y equitativa.

### Screenshot

![Turnos](https://github.com/ro85/Maas_RoR/tree/master/app/assets/images/set_shift.png)

## Tecnologias

Tecnologías utilizadas en el proyecto:
* [Rails]: Version 6.0.4.6 
* [Ruby]: Version 2.6.6p146
* [Node.js]: Version 8
* [Database]: Postgresql

## Instalación

```
$ git clone git@github.com:ro85/Maas_RoR.git
$ cd Maas_RoR

$ bundle install
$ yarn install
$ rails db:create db:migrate
```
información adicional: para usar la aplicación en un entorno de desarollo, use ```rails s``` para comenzar.

Para generar seeds de prueba
```
$ rails db:seed
```

## Estructura

![Schema](https://github.com/ro85/Maas_RoR/tree/master/app/assets/images/schema.png)

## Credenciales

Credenciales del seed
```
* Admin role:
    email: admin@mail.com
    password: 123456

* Dev role:
    email: dev@mail.com
    password: 123456
```
## Licencia
[MIT](https://choosealicense.com/licenses/mit/)