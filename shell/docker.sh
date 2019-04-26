# zsh auto completion
etc=/Applications/Docker.app/Contents/Resources/etc
ln -s $etc/docker.zsh-completion /usr/local/share/zsh/site-functions/_docker
ln -s $etc/docker-machine.zsh-completion /usr/local/share/zsh/site-functions/_docker-machine
ln -s $etc/docker-compose.zsh-completion /usr/local/share/zsh/site-functions/_docker-compose

docker version
docker info
docker help run

docker ps
docker ps -a
docker ps -l
docker ps -n 3
docker images
docke image rm nginx
# docker rmi nginx
docker rmi `docker images -a -q`

docker start webserver
docker restart webserver
docker stop webserver
docker kill webserver
docker [container] rm webserver
docker rm -f webserver 
docker rm `docker ps -a -q`
# docker attach daemon_ubuntu
docker logs --tail 10 -tf daemon_ubuntu
docker top daemon_ubuntu
docker stats daemon_ubuntu
docker inspect daemon_ubuntu
# query container ip
docker inspect --format='{{.NetworkSettings.IPAddress}}' <container-id>

# control + c
# docker exec -i -t daemon_ubuntu /bin/bash
docker exec -d daemon_ubuntu touch /tmp/tmp.txt
docker search puppet
docker pull ubuntu:12.04
docker login
docker commit <container-id> <repository-name/image-name:tag>
docker build -t <repository-name/image-name:tag> .
docker history <container-id>
docker port <container-id> <port>
docker push <repository-name/image-name:tag>
docker tag <container-id> <registry-host/repository-name/image-name>

docker network create <network>
docker run --net=<network>
docker network inspect <network>
docker network connect <network> <container-name>
docker network disconnect <network> <container-name>

docker run hello-world
docker run -d -p 80:80 --name webserver nginx
# docker run -i -t ubuntu /bin/bash
docker run --restart=always --name daemon_ubuntu -d ubuntu /bin/sh -c "while true; do echo hello world; sleep 1; done"
docker run -i -t ubuntu:12.04 /bin/bash

# private docker registry
# docker run -v host-path:container-path
docker run -d -p 5000:5000 --restart always --name registry -v /tmp/docker/registry:/var/lib/registry registry:2
# curl http://localhost:5000/v2/_catalog
docker pull ubuntu
docker tag ubuntu localhost:5000/ubuntu
docker push localhost:5000/ubuntu
# create repository on dockerhub and push image to dockerhub
# docker push colddew/micro-service-a:1.0-SNAPSHOT
docker rmi localhost:5000/ubuntu
docker pull localhost:5000/ubuntu

# jenkins
# https://jenkins.io/doc/book/installing/#installing-jenkins
# http://localhost:8080/blue
# http://localhost:8888
# docker run -p 8888:8080 -p 50000:50000 jenkins/jenkins:lts
docker run -d -p 8888:8080  -p 50000:50000 -v $HOME/docker/jenkins:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --name jenkins jenkinsci/blueocean
docker exec -it jenkins bash
# docker exec -it -u root <contain-id> /bin/bash
docker logs jenkins -f

# docker host port forwarding
brew install socat
socat TCP-LISTEN:2375,reuseaddr,fork UNIX-CONNECT:/var/run/docker.sock &
# tcp://<host-ip>:2375

# add access privilege for jenkins container
# groupadd docker
# gpasswd -a jenkins docker
# newgrp docker
# groups jenkins
# docker ps

# gitlab
# http://localhost/gitlab
# docker run -d -p 443:443 -p 80:80 -p 22:22 --name gitlab --restart always -v $HOME/docker/gitlab/config:/etc/gitlab -v $HOME/docker/gitlab/logs:/var/log/gitlab -v $HOME/docker/gitlab/data:/var/opt/gitlab gitlab/gitlab-ce:latest
# http://localhost:8080/gitlab
docker run -d -p 8443:443 -p 8080:80 -p 22:22 --name gitlab --restart always -v $HOME/docker/gitlab/config:/etc/gitlab -v $HOME/docker/gitlab/logs:/var/log/gitlab -v $HOME/docker/gitlab/data:/var/opt/gitlab gitlab/gitlab-ce:latest
# webhook for jenkins
http://<jenkins>/gitlab/build_now/<job-name>
http://<jenkins>/project/<job-name>

# portainer
# http://localhost:9000
docker run -d -p 9000:9000 --restart=always -v /var/run/docker.sock:/var/run/docker.sock --name prtainer portainer/portainer

# docker-compose
docker-compose --version
docker-compose up -d
docker-compose ps
docker-compose logs
docker-compose stop
docker-compose start
docker-compose rm

# track docker logs
pred='process matches ".*(ocker|vpnkit).*" || (process in {"taskgated-helper", "launchservicesd", "kernel"} && eventMessage contains[c] "docker")'
/usr/bin/log stream --style syslog --level=debug --color=always --predicate "$pred"

# spring profile and remote test support
docker run -e "SPRING_PROFILES_ACTIVE=dev" -p 8080:8080 -t springio/gs-spring-boot-docker
docker run -e "SPRING_PROFILES_ACTIVE=prod" -p 8080:8080 -t springio/gs-spring-boot-docker
docker run -e "JAVA_OPTS=-agentlib:jdwp=transport=dt_socket,address=5005,server=y,suspend=n" -p 8080:8080 -p 5005:5005 -t springio/gs-spring-boot-docker

# harbor
# https://github.com/goharbor/harbor-helm
cd harbor-helm
helm install --name harbor .
helm upgrade --set externalURL='http://core.harbor.plantlink.io' harbor .
helm delete --purge harbor

# sonatype nexus
docker run -d -p 8081:8081 --name nexus -v $HOME/docker/nexus-data:/nexus-data sonatype/nexus3
# http://localhost:8081
curl -u admin:admin123 http://localhost:8081/service/metrics/ping
docker logs -f nexus
# docker run -d -p 8081:8081 --name nexus -e INSTALL4J_ADD_VM_PARAMS="-Xms2g -Xmx2g -XX:MaxDirectMemorySize=3g  -Djava.util.prefs.userRoot=$HOME/docker/nexus-data/prefs" sonatype/nexus3
# docker volume create --name nexus-data
# docker run -d -p 8081:8081 --name nexus -v nexus-data:/nexus-data sonatype/nexus3
