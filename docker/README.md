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

Here we have the **.env** file that allows us to customize our working environment variables.

In this case we only define the port that Nuxeo is using in Docker:

- NUXEO_PORT=8080

### **Dockerfile**

### **Makefile**

**Makefile** is a handy automation tool, that serves to run commands more efficiently without having to know all commands every time we run.

**rmi**:

- Destroy the docker image.

**rm**:

- Stop and destroy the container.

**clean**:

- Not only destroy docker image but also stop and destroy the container.

**compile**:

- Run the **package_build.sh** script mentioned above. The logs are presenting both on the command line and packages_build.log file.

**build**:

- Clean and compile;
- Generate the Docker image through Dockerfile. Thel tag is equal for anyone who runs this command, that is, **"3d.investigation/nuxeo"**. The logs are presenting both on the command line and build.log file.

**start**:

- Raises a new container with name **3d.investigation-nuxeo**, with configs of .env file amd also with Port 9998 that is overrided through the following scipt:

``` Makefile
ifndef PORT
override PORT = 9998
endif
```  

**start-background**:

- Do the same thing as the previous command, the difference is that is running in background. The port is overrided the same way:

``` Makefile
ifndef DEPLOY_PORT
override DEPLOY_PORT = 9998
endif
```

**run**:

- Build and start - used on local machine.

**deploy**:

- Build and start in background - used on an ITE.

**console**:

- Has the function of entering into the container using bash.


	









## Use

Use `make start` to start **Nuxeo** on a localhost .env, on the http location `http://localhost:8080/nuxeo`.

To stop do `make clean`.

## Install

Use `make deploy` to build and run the instance on the port 9999 by default. To override the port use `make deploy PORT=ANY_PORT`.

```bash

cd /opt
mkdir nuxeo
cd nuxeo
sudo chmod -R 777 /opt/nuxeo/
git clone https://github.com/JoseRodrigues443/nuxeo-deploy-tools.git

sudo chmod -R 777 nuxeo-deploy-tools
cd /opt/nuxeo/nuxeo-deploy-tools/docker
sudo make deploy

```

> To check if the port is being used use the command ` lsof -Pi :PORT -sTCP:LISTEN -t` if it has value, then is used.
