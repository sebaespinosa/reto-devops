# Consideraciones

1. En la App agregué además nodemon para efectos de facilitar el desarrollo
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Reto 1

**Supuestos y consideraciones**:
   1. Como se solicita una imagen lo más pequeña posible, solo es necesario dockerizar la app final, no los test
   2. El archivo DockerFile contiene los comentarios y documentación del trabajo realizado
      1. Se asume que no es necesario obtener desde el repositorio la última versión de la App

**Respuesta**
   1. Para construir la imagen, dentro del directorio respuestas\Reto1, ejecutar
      ```
      docker build -t clm-reto1 .
      ```
   2. Para ejecutar la imagen
      ```
      docker run --name reto1 -p 80:3000 -d clm-reto1
      ```
   3. Se puede acceder a la app en http://localhost

# Reto 2

**Supuestos y consideraciones**:
   1. Para facilitar el Docker-Compose subí la imagen del reto 1 a DockerHub en https://hub.docker.com/repository/docker/sebawhatif/clm-reto1

**Respuesta**
   1. Para construir y iniciar el servicio, dentro del directorio respuestas\Reto1, ejecutar
      ```
      docker-compose up --build
      ```
   2. Las claves para la autentificación básica son:
      ```
      user:    clm
      clave:   pass
      ```
   3. Como generar el certificado SSL requiere de una URL válida, para efectos de la prueba y demostrar el concomiento solo comento los pasos a seguir
      1. Usando Certbot se puede generar fácilmente el certificado SSL desde el servidor, solo se requiere contar con un registro DNS tipo A válid
      2. Primero se debe generar el certificado, lo que que nos generará los archivos correspondientes
      3. Modificar el archivo "docker-compose.yaml" para copiar en el volumen los archivos generados al crear al certificado. La imagen de Nginx ya trae la configuración para poder trabajar con SSL. Agregar estas líneas:
         ```
         volumes:
            - ./reverse_proxy.conf:/etc/nginx/conf.d/default.conf
            - ./htpasswd:/etc/nginx/.htpasswd
            - ./site_crt_file.crt:/etc/nginx/certs/site_crt_file.crt
            - ./site_crt_file.key:/etc/nginx/certs/site_crt_file.key
         ```
      4. Modificar el archivo docker-compose.yaml para que ahora copie el archivo "reverse_proxy_con_ssl.conf" en vez del archivo "reverse_proxy.conf". Este archivo tiene las siguientes diferencias en la configuración de Nginx:
         1. Todo el tráfico recibido en el puerto 80 es automaticamente redireccionado al puerto 443, redireccionando la url solicitada desde http:// a https://
         2. El puerto 443 tiene configurada la utilización de certificado SSL

# Reto 3

**Importante:** Mi conocimiento actual de herramientas de CI/CD es en Jenkin, no he tenido la oportunidad de trabajar con GitLab (de hecho uso github para mis proyectos), por eso para este reto entrego el pipeline para Jenkins.

**Respuesta**
   1. Crear un nuevo pipeline, con la opción "Pipeline Script from SCM" para que obtenga desde el repo el código de la App, en esta etapa se configura la URL del repo. Jenkin permite ingresar las credenciales si el repo es privado.
   2. En el archivo JenkisFile se encuentra implementados y documentadas las diferentes etapas del pipeline como se implementa en Jenkins. Para efectos de la prueba se ha simplificado el proceso en los scripts para ejecutar las tareas, sin incorporar en estos scripts en Bash detenciones en caso de falla y/o validaciones, solo ejemplifica las tareas que se realizan en estos scripts bash.
   3. En la configuración del Job en Jenkins (un Job ejecuta Pipelines) se puede ajustar la frecuencia con que se realiza el trabajo, notificaciones, y otras configuraciones más.

# Reto 4

**Importante:** Mi experiencia es trabajando con Google Kubernetes Engine, por lo que para esta respuesta entregaré por acá los archivos yaml correspondientes y los comandos para implementarlo. Tengo entendido que no difieren de Minikube o Microk8s.

**Supuestos y consideraciones**:
   1. Para facilitar el Docker-Compose subí la imagen del reto 1 a DockerHub en https://hub.docker.com/repository/docker/sebawhatif/clm-reto1 y trabajar este reto directamente con la imagen desde acá.
   2. Se asume que para ejecutar la aplicación no es necesario un PVC para almacenar los datos.
   3. Se asume una versión simplificada solo con el puerto 80 y la versión sin SSL de la App en Node.

**Respuesta**
   1. Se crea el deployment correspondiente, es decir, la instancia de la imagen con nuestra app. En esta configuración se aplican configuraciones como la imagen a utilizar, puertos, y parámetros a medir para el auto-escalamiento. Para aplicar ejecutar dentro del cluster el comando:
      ```
      kubectl apply -f 1_deployment.yml
      ```
   2. Creamos el servicio de LoadBalancer para exponer nuestro deploment a internet. En este archivo configuro si quiero asignar una IP estática disponible a este LoadBalancer, y el mapeo de puerto correspondientes. En este caso el puerto 80 del loadbalancer que es expuesto al mundo, mapea al puerto 3000 de nuestro pod donde se ejecuta nuestra app. Para aplicar ejecutar dentro del cluster el comando:
      ```
      kubectl apply -f 2_loadbalancer.yml
      ```
   3. Creamos el servicio de escalado automático. Este archivo yaml contiene la configuración como la cantidad mínima y máximas de réplicas para escalar horizontalmente, y los criterios bajo los cuales escalar, como por ejemplo "uso promedio de CPU > 80%". Para escalar en base a estas métricas, en el archivo de configuración del deployment se deben activar las métricas a monitorear y en el este archivo de auto escalamiento, configurar las reglas que se dispara en base a estas métricas. Para aplicar ejecutar dentro del cluster el comando:
      ```
      kubectl apply -f 3_autoscale.yml
      ```
   4. Podemos monitorear con actualización cada 1 segundo el estado de nuestro clúster completo con el comando
      ```
      kubectl watch -n1 get all
      ```

# Reto 5

No complete este reto ya que no tengo conocimientos sobre Helm.

Para monitoreo tengo experiencia trabajando con Zabbix, Prometheus, y Grafana

# Reto 6

**Supuestos y consideraciones**:
   1. El archivo de configuración de Terraform que entrego es genérico, es decir, no tiene un namespace definido ni nombres especiales para los roles, tratando de ser lo más representativo posible.

**Respuesta**
   1. En la carpeta respuestas>Reto6 se encuentra el archivo terraformfile.tf que contiene la configuración deseada.
   2. La primera sección 'resource "kubernetes_role" "solo_ver_pods"' se crea un recurso de terraform del tipo Role de Kubernete, con el nombre "solo_ver_pods" para ejemplificar que es un rol de solo lectura.
      1. En los atributos se configuran el nombre y otras variables, en particular el atriburo "verbs" donde se indican las actividades que puede realizar el rol, limitando solo a "watch", es decir, solo ver.
   3. En la segunda sección 'resource "kubernetes_role_binding" "solo_ver_pods_binding"' se crea un binding para poder utilizar el rol definido en el paso anterior.
   4. Para aplicar el cambio se deben ejecutar los comandos de terraform:
      ```
      terraform init
      terraform plan
      terraform apply
      ```

# Reto 7

**Supuestos y consideraciones**:
   1. No me queda claro del enunciado del problema si se desea que el Makefile automtice todos los retos, por lo que asumiré que solo es para automatizar la puesta en marcha de nuestra App.
   2. Es la tecnología de la que tengo menor conocimiento y con la cuál me ha tocado trabajar muy poco (en la programación de estos archivos).

**Respuesta**
   1. En la carpeta respuestas>Reto6 se encuentra el archivo Makefile con la automatización de nuestra App
   2. Para ejecutar el archivo solo es necesario ingresar al directorio y ejecutar el comando "make"