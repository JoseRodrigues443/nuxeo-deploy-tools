# Nuxeo Docker ENV

Demonstration of an installation of a Nuxeo server under Docker

See references here:

- https://hub.docker.com/_/nuxeo
- https://doc.nuxeo.com/nxdoc/build-a-custom-docker-image/
- https://doc.nuxeo.com/nxdoc/docker-image/

## What do we need? 

### scripts

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

### configs
- .env

### Dockerfile

### Makefile


