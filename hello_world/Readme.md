* Use Docker toolbox, and Docker Quickstart Terminal on windows
* docker image build -t hellom:0.01 . 
* docker run --restart unless-stopped --name hellom -d -p 8080:8080 hellom:0.01 
* docker run --network=host --restart unless-stopped --name hellom -d -p 0.0.0.0:8080:8080 hellom:0.01 
* docker exec -it $(docker ps -aq) /bin/bash
* docker kill $(docker ps -aq);docker rm $(docker ps -aq);
* docker-machine.exe ssh default
* curl http://10.0.2.15:8080/

## Docker pus
* docker ps -aq
* docker commit aa846297de5b mohan-nodem-hello
* docker tag mohan-nodem-hello mohanmca/kubeimages:0.01
* docker login
* docker push mohanmca/kubeimages:0.01