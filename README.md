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
Software que permite coordinar y asignar los turnos de guardia de monitoreo de manera automática y equitativa entre todos los miembros del equipo.
Mediante la creacion de contratos por parte del administrador según las especificaciones de cada cliente, se le habilitara a cada usuario con el rol de dev una agenda con los horarios para cada contrato para que se inscriba como disponible para cubrir el turno que luego seran asignados de manera automática y equitativa.
Pudiendo luego el administrador reasignar turnos según conveniencia y cambios de disponibilidades.

### Screenshot

<img src="/app/assets/images/set_shift.png" alt="set_shift">

## Tecnologias

Tecnologías utilizadas en el proyecto:
* [Rails]: Version 6.0.4.6 
* [Ruby]: Version 2.6.6p146
* [Node.js]: Version 8
* Postgresql

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

<img src="/app/assets/images/schema.jpg" alt="schema">

## Credenciales

A modo de pruebas puede ingresar a [maas-ror](https://maas-ror.herokuapp.com)

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