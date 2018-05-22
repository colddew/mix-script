docker version
docker info
docker help run

docker ps
docker ps -a
docker ps -l
docker ps -n 3
docker images
docke image rm nginx

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

docker run hello-world
docker run -d -p 80:80 --name webserver nginx
// docker run -i -t ubuntu /bin/bash
docker run --restart=always --name daemon_ubuntu -d ubuntu /bin/sh -c "while true; do echo hello world; sleep 1; done"
