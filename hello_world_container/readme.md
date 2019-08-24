* Use Docker toolbox, and Docker Quickstart Terminal on windows

```bash
# Build image using following command
docker image build -t hellom:0.01 . 

#  Execute the application image using following command
docker run --restart unless-stopped --name hellom -d -p 8080:8080 hellom:0.01 

#  Execute the application image using following command, but network make use the host network
docker run --network=host --restart unless-stopped --name hellom -d -p 0.0.0.0:8080:8080 hellom:0.01 

#  Execute adhoc command/script inside the container that is running
docker exec -it $(docker ps -aq) /bin/bash

#  Stop the running container
docker kill $(docker ps -aq);docker rm $(docker ps -aq);

#  SSH into docker node inside windows
docker-machine.exe ssh default

#  Use below command when container is running (from inside the docker-node or docker-machine)
curl http://10.0.2.15:8080/
```

## Docker commands
```bash
# Docker help
docker ps --help

# Display containers in quiet mode (display only hash)
docker ps -aq

# create new image from container
docker commit aa846297de5b mohan-nodem-hello

# Tag the image before uploading to docker hub
docker tag mohan-nodem-hello mohanmca/kubeimages:0.01

# Login and upload the image
docker login
docker push mohanmca/kubeimages:0.01
```
## Reference
* [Ngnix image](https://github.com/dockerfile/nginx/blob/master/Dockerfile)