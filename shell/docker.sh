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
// docker rmi nginx
docker rmi `docker images -a -q`

docker start webserver
docker restart webserver
docker stop webserver
docker kill webserver
docker [container] rm webserver
docker rm -f webserver 
docker rm `docker ps -a -q`
// docker attach daemon_ubuntu
docker logs --tail 10 -tf daemon_ubuntu
docker top daemon_ubuntu
docker stats daemon_ubuntu
docker inspect daemon_ubuntu
// control + c
// docker exec -i -t daemon_ubuntu /bin/bash
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
// docker run -i -t ubuntu /bin/bash
docker run --restart=always --name daemon_ubuntu -d ubuntu /bin/sh -c "while true; do echo hello world; sleep 1; done"
docker run -i -t ubuntu:12.04 /bin/bash

# private docker registry
# docker run -v host-path:container-path
docker run -d -p 5000:5000 --restart always --name registry -v /tmp/docker/registry:/var/lib/registry registry:2.6.2
# curl http://localhost:5000/v2/_catalog
docker pull ubuntu
docker tag ubuntu localhost:5000/ubuntu
docker push localhost:5000/ubuntu
docker rmi localhost:5000/ubuntu
docker pull localhost:5000/ubuntu

# jenkins
# http://localhost:8080/blue
docker run -d -p 8080:8080 -v $HOME/docker/jenkins:/var/jenkins_home --name jenkins-blueocean jenkinsci/blueocean
docker exec -it jenkins-blueocean /bin/bash
docker logs jenkins-blueocean

# gitlab
# http://localhost/gitlab
docker run -d -p 443:443 -p 80:80 -p 22:22 --name gitlab --restart always -v $HOME/docker/gitlab/config:/etc/gitlab -v $HOME/docker/gitlab/logs:/var/log/gitlab -v $HOME/docker/gitlab/data:/var/opt/gitlab gitlab/gitlab-ce:latest

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
