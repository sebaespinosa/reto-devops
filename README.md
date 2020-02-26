# Reto-DevOps CLM
![CLM Consoltores](./img/clm.png)

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
![Tox](./img/jest.jpg)

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
## El desafío comienza aquí

Tienes que hacer un **fork** de este repositorio para completar los siguientes desafíos en tu propia cuenta de `gitlab`. **Siéntase libre de resolver el desafío que desees**.

Una vez completado, no olvide devolver la solución.

Si tiene alguna duda, no dude en [abrir un issue](https://gitlab.com/clm-public/reto-devops/issues) para hacer cualquier pregunta sobre cualquier desafío.
