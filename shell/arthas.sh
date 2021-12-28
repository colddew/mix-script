# https://github.com/alibaba/arthas/blob/master/README_CN.md
# curl -O https://alibaba.github.io/arthas/arthas-boot.jar
# jps -lvVm
java -jar arthas-boot.jar -h
java -jar arthas-boot.jar
# java -jar arthas-boot.jar --target-ip 0.0.0.0

dashboard

thread <pid>
thread -n 5
thread -b

jvm

options

watch <package.ClassName> <MethodName> returnObj
watch <package.ClassName> <MethodName> {params,returnObj}
watch <package.ClassName> <MethodName> {params[0], throwExp} -e

trace <package.ClassName> <MethodName> '#cost>100'

stack <package.ClassName> <MethodName>

monitor -c 3 <package.ClassName> <MethodName>

tt -t <package.ClassName> <MethodName>
tt -l
tt -s 'method.name=="<MethodName>"'
tt -i <tracd-id> -p

jad <package.ClassName>
sc -d *<ClassName>

redefine -c <classLoaderHash> <newClassName>
redefine /<path>/<newClass.class>

options unsafe true
stack java.lang.System gc

vmtool --action getInstances --className redis.clients.jedis.JedisPool --express 'instances[0].getNumActive()'
vmtool --action getInstances --className redis.clients.jedis.JedisPool --express 'instances[0].getNumWaiters()'
vmtool --action getInstances --className redis.clients.jedis.JedisPool --express 'instances[0].getNumIdle()'
# java -jar arthas-boot.jar 22396 -c "vmtool --action getInstances --className redis.clients.jedis.JedisPool --express 'instances[0].getNumIdle()'"

heapdump /<path>/dump.hprof
heapdump --live /<path>/dump.hprof

mbean -i 1000 java.lang:type=Threading *Count

exit/quit
stop
