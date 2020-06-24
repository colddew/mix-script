# https://github.com/alibaba/arthas/blob/master/README_CN.md
# curl -O https://alibaba.github.io/arthas/arthas-boot.jar
java -jar arthas-boot.jar -h
java -jar arthas-boot.jar
# java -jar arthas-boot.jar --target-ip 0.0.0.0
dashboard
thread <pid>
thread -n 5
thread -b
jvm
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
options unsafe true
stack java.lang.System gc
exit/quit
stop
