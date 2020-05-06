# https://github.com/alibaba/arthas/blob/master/README_CN.md
# curl -O https://alibaba.github.io/arthas/arthas-boot.jar
java -jar arthas-boot.jar -h
java -jar arthas-boot.jar
# java -jar arthas-boot.jar --target-ip 0.0.0.0
dashboard
thread <pid>
thread -n 5
thread -b
sc -d *<ClassName>
jad <package.ClassName>
jvm
watch <package.ClassName> <MethodName> returnObj
watch <package.ClassName> <MethodName> {params[0], throwExp} -e
trace <package.ClassName> <MethodName> '$cost>100'
trace -j <package.ClassName> <MethodName>
tt -t <package.ClassName> <MethodName
tt -i <tracd-id> -p
options unsafe true
stack java.lang.System gc
exit/quit
stop
