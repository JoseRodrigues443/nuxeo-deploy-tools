# Nuxeo Docker ENV

Demonstration of an installation of a Nuxeo server under Docker

See references here:

- https://hub.docker.com/_/nuxeo
- https://doc.nuxeo.com/nxdoc/build-a-custom-docker-image/
- https://doc.nuxeo.com/nxdoc/docker-image/

## What do we need? 

### **scripts**

Inside this folder we have the **package_build.sh** file that deals with all the compilation logic.

In a high level, we have 3 main parts envolved:
- sources
- tmp
- packages

In the **sources** folder are all the original zip files.

It is necessary to go through them all and unzip them to the **tmp** folder. The compilation logic part is done in this folder:

- If the folder content **is compiled** (without **pom.xml** file and with the **install.xml** file, which is a compiled version of pom.xml), it is ready to be copied to the **package** folder which will save all files that are ready to be copied to the docker.

- If the folder content **is not compiled** (with **pom.xml** file), it is necessary to do more steps before it is copied to the **package** folder and consequently to the docker.

  - It is necessary to build the maven to be able to obtain the SNAPSHOT.

### **configs**
- .env

### **Dockerfile**

### **Makefile**



## Use

Use `make start` to start **Nuxeo** on a localhost .env, on the http location `http://localhost:8080/nuxeo`.

To stop do `make clean`.

## Install

Use `make deploy` to build and run the instance on the port 9999 by default. To override the port use `make deploy PORT=ANY_PORT`.

```bash

cd /opt
mkdir nuxeo
cd nuxeo
sudo chmod -R 777 ./
git clone https://github.com/JoseRodrigues443/nuxeo-deploy-tools.git

sudo chmod -R 777 nuxeo-deploy-tools
cd nuxeo-deploy-tools/docker
make deploy

```

> To check if the port is being used use the command ` lsof -Pi :PORT -sTCP:LISTEN -t` if it has value, then is used.
