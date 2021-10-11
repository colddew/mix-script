# nacos standalone
cd <nacos-home>/bin
sh startup.sh -m standalone
# tail -f /usr/local/nacos/logs/start.out
# http://127.0.0.1:8848/nacos/
sh shutdown.sh
# service register & discovery
curl -X POST 'http://127.0.0.1:8848/nacos/v1/ns/instance?serviceName=nacos.naming.serviceName&ip=20.18.7.10&port=8080'
curl -X GET 'http://127.0.0.1:8848/nacos/v1/ns/instance/list?serviceName=nacos.naming.serviceName'
# config
curl -X POST "http://127.0.0.1:8848/nacos/v1/cs/configs?dataId=nacos.cfg.dataId&group=test&content=HelloWorld"
curl -X GET "http://127.0.0.1:8848/nacos/v1/cs/configs?dataId=nacos.cfg.dataId&group=test"

# nacos docker
# https://hub.docker.com/r/nacos/nacos-server
docker search nacos
docker pull nacos/nacos-server
docker images
docker run --name nacos -e MODE=standalone -p 8848:8848 -d nacos/nacos-server[:tag]
docker logs -f nacos
docker logs --tail 10 -tf nacos
docker exec -it nacos /bin/bash
