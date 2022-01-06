# syntax=docker/dockerfile:1

#Cómo se solicita una imagen del menor tamaño posible, uso la versión alpine
FROM node:17-alpine

#Se asume que no es necesario volver descargar desde GitHub la última versión de la App de Node

#Creo el directorio donde alojar la aplicación y configuro al usaurio node como su propietario
RUN mkdir -p /home/node/app/node_modules
#Indico el directorio de trabajo
WORKDIR /home/node/app
#Copio los archivos de la app al directorio de trabajo
COPY nodeapp/package*.json ./
COPY nodeapp/index.js index.js
#instalo la dependencias de mi app
RUN npm install

RUN chown -R node:node /home/node/app

#ejecuto y expongo la app a través del puerto 3000
EXPOSE 3000

#Realizo la instalación de la App no como Root, sino como usaurio node
#en el paso anterior modificamos el propietario al usaurio node
USER node
CMD [ "node", "index.js" ]