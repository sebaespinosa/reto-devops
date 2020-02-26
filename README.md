# Reto-DevOps CLM
![CLM Consoltores](./img/clm.png)
## Proceso de Selección

Consta de 3 paso.
  1. Contacto de RRHH con el candidato, para evaluar cultura ....... y entrega de este reto.
  2. Entrevista con equipo técnico para evaluar el reto y conocernos
  3. Entrevista RRHH para oferta laboral.

Este desafío fue diseñado para buscar tus habilidades DevOps. Este repositorio contiene una aplicación simple en NodeJs.

## La app
![NodeJs](./img/nodejs.png)

```bash
$ git clone https://gitlab.com/clm-public/reto-devops.git
Cloning into 'reto-devops'...
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (3/3), done.
$ cd ./reto-devops

```
### Instalar Dependencias
```bash
$ npm install
npm WARN basicservice@1.0.0 No repository field.
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@2.1.2 (node_modules/fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@2.1.2: wanted {"os":"darwin","arch":"any"} (current: {"os":"linux","arch":"x64"})

added 530 packages from 308 contributors and audited 1203947 packages in 34.589s

21 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
```
### Ejecutar Test
![Jest](./img/jest.jpg)

```bash
$ npm run test

> basicservice@1.0.0 test /basic-unit-test
> jest

 PASS  tests/sum.test.js
 PASS  tests/string.test.js

Test Suites: 2 passed, 2 total
Tests:       3 passed, 3 total
Snapshots:   0 total
Time:        5.655s
Ran all test suites.
```

### Ejecutar la app
```bash
$ node index.js
Example app listening on port 3000!
```
Podrá acceder a la API localmente en el puerto `3000`.

```bash
$ curl -s localhost:3000/ | jq
{
  "msg": "ApiRest prueba"
}
$ curl -s localhost:3000/public | jq
{
  "public_token": "12837asd98a7sasd97a9sd7"
}
$ curl -s localhost:3000/private | jq
{
  "private_token": "TWFudGVuIGxhIENsYW1hIHZhcyBtdXkgYmllbgo="
}
```

NT: En nuestro equipo consideramos que cada aplicación debe venir bien documentada por parte del desarrollados, para que el equipo de **DevOps** puede realizar los procesos de automatización de una manera mas eficaz.

## El desafío comienza aquí
Tienes que hacer un **fork** de este repositorio para completar los siguientes desafíos en tu propia cuenta de `gitlab`. **Siéntase libre de resolver el desafío que desees.** La cantidad de desafios resueltos nos va a permitir valorar tu habilidad y realizar una **oferta en base a las mismas**.

Una vez completado, no olvide devolver la solución.

Si tiene alguna duda, no dude en [abrir un issue](https://gitlab.com/clm-public/reto-devops/issues) para hacer cualquier pregunta sobre cualquier desafío.

### Reto 1. Dockerize la aplicación
![docker](./img/nodedoker.jpg)
¿Qué pasa con los contenedores? En este momento *(2020)*, los contenedores son un estándar para implementar aplicaciones *(en la nube o en sistemas locales)*. Entonces, el desafío es:
1. Construir la imagen más pequeña que pueda. Escribe un buen Dockerfile :)
2. Ejecutar la app como un usuario diferente de root.

### Reto 2. Docker Compose
![docker](./img/docker-compose.png)
Una vez que haya dockerizado todos los componentes de la API *(aplicación de NodeJs y base de datos)*, estará listo para crear un archivo docker-compose, en nuestro equipo solemos usarlo para levantar ambientes de desarrollo antes de empezar a escribir los pipeline.

### Reto 3. Probar la aplicación en cualquier sistema CI/CD
![docker](./img/cicd.jpg)
Como buen ingeniero devops, conoces las ventajas de ejecutar tareas de forma automatizada. Hay algunos sistemas de cicd que pueden usarse para que esto suceda. Elige uno, travis-ci, gitlab-ci, circleci ... lo que quieras. Danos una tubería exitosa. **gitlab-ci** es nuestra herramienta de uso diaro por lo cual obtendras puntos extras si usas gitlab.
