#El tag "all" nos sirve como PHONY target nos permite ejecutar secciónes del código cómo si fueran archivos
#sin la necesidad de tener que crear archivos para cada uno de estas secciones
all: install test start

install: ;@echo "Instalando NodeJs App....."; \
	apt install -y git \
	apt install -y nodejs \
	git clone https://gitlab.com/clm-public/reto-devops.git  \
	npm install

test: ;@echo "Ejecutando Tests....."; \
	npm run test

start : ;@echo "Iniciando NodeJs App....."; \
	node index.js