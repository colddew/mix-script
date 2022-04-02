# curl encoding
iconv -l
iconv -f gb2312 -t utf-8

# test nginx gzip compress
curl -I -H "Accept-Encoding: gzip, deflate" "https://www.plantlink.cn"

# upload image to baidu
curl -i -F 'image=@3.jpg' 'http://image.baidu.com/pictureup/uploadshitu?pos=upload&uptype=upload_pc&fm=index'
curl -i -F 'image=@3.jpg' 'http://image.baidu.com/pictureup/uploadshitu?pos=upload&uptype=upload_pc&fm=index' -L

# access through proxy server
curl -x <proxy-ip>:<proxy-port> www.baidu.com

# query network latency
curl -L --output /dev/null --silent --show-error --write-out 'lookup: %{time_namelookup}\nconnect:%{time_connect}\nappconnect:%{time_appconnect}\npretransfer:%{time_pretransfer}\nredirect:%{time_redirect}\nstarttransfer: %{time_starttransfer}\ntotal:%{time_total}\n' 'https://appleid.apple.com/auth/keys'
# lookup -> dns
# pretransfer - lookup -> tcp
# starttransfer - pretransfer -> server handler
# total - starttransfer -> content transfer

# access https url
curl -v --insecure https://<url>

# network trace
mtr —no-dns appleid.apple.com

# batch http get
for i in {1..100};do curl -X GET https://url -H "X-User-ID: userId" -H "X-Device-NO: deviceNo" -H "Authorization: auth";done;

# format directory
tree
tree -a
tree -L 3
tree d
tree tree -P '*Contain*' --prune
tree -I '*NotContain*' --prune

# format json
echo '' | jq .

# base64
echo '' | base64
echo '' | base64 -D

# hash
echo '' | md5
echo '' | shasum
# echo '' | openssl sha1
echo '' | shasum -a 256
# echo '' | openssl dgst -sha256
# alias sha256="openssl dgst -sha256"

# unicode encode/decode
native2ascii
native2ascii -reverse

# urlencode/urldecode
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'

# ngrok
~/Downloads/ngrok http 8888
# inspect traffic
http://localhost:4040

# dns
# /etc/resolv.conf
# dig @dnsserver name querytype
dig @8.8.8.8 www.baidu.com A
dig @<dns-server-ip> +trace
nslookup <domain-name>

# stress test
ab -n 1000 -c 100 -v 2 [-H "<header>"] <url>

# maven
# list jar dependency
mvn dependency:tree -Dverbose -Dincludes=<groupId>:<artifactId> -Dexcludes=<groupId>:<artifactId>
# check unused dependency
mvn dependency:analyze-only
# clean duplicate dependency
mvn dependency:analyze-duplicate

# calculate gzip compression ratio
gzip -cv <file-name> > /dev/null

# gzip
gzip x.txt
gzip -d x.txt.gz

# zip
zip -r x.zip logs/
unzip x.zip

# file system
fdisk -l
fdisk <raw-device>
mkfs -t ext3 <partition-device>
mount
mount <partition-device> <mount-point>
echo "<partition-device> <mount-point> ext3 defaults 0 0" >> /etd/fstab
umount <partition-device>
fsck -t ext3 <partition-device>
badblocks -v <partition-device>

# monitor
free -h
lsof -i tcp:port
yum install -y dstat
dstat 5
dstat --top-mem --top-io --top-cpu
yum install -y mtr
mtr -v
top -n <refresh-times>
top -Hp <pid>
# P order by CPU
# M order by memory
# c complete command

# tuning
jps -lmvV
# gc
jstat -gcutil <pid> [interval][ms/s] [count]
# heap dump
jmap -heap <pid>
jmap -histo:live <pid>
jmap -dump:file=<dump.hprof>,format=b <pid>
jmap -dump:live=<dump.hprof>,format=b <pid>
jmap -heap <pid>
# thread snapshot
jstack -l <pid>
jstack -m <pid>
jstack -F <pid>
jcmd
jinfo -flags <pid>
jinfo -sysprops <pid>
ps -eo pid,lstart,etime,cmd | grep -v grep | grep <process-name>

# gc
# http://gceasy.io/
# https://fastthread.io/
# -Xloggc:/opt/atlassian/jira/logs/atlassian-jira-gc-%t.log -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=5 -XX:GCLogFileSize=20M -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+PrintGCCause
# -XX:HeapDumpPath=/temp/dumps.bin -XX:+HeapDumpOnOutOfMemoryError -XX:+PrintGCDetails  -XX:+PrintGCDateStamps  -XX:+PrintGCApplicationConcurrentTime -XX:+PrintGCApplicationStoppedTime

# CPU 100% & Full GC problem
# check cpu and thread
top -Hp <pid> 
# convert thread id to hex
# printf "%x\n" 10
# user thread
jstack -l <pid> >> jstack.log
# vm thread
jstat -gcutil <pid> <period> <times>
jmap -dump:format=b,file=<heap.hprof> <pid>
jmap -dump:format=b,file=<heap.bin> <pid>
mat

# common used
chown -R colddew[:admin] <path>
chgrp -R admin <path>
ulimit -a
find / -name <file-name>
tar -zcvf <zip-file-name>.tar.gz <zip-path>
tar -zxvf <zip-file-name>.tar.gz
tar tvf <zip-file-name>.tar.gz
df -h
du -h .
grep [-ivnc] '<search-content>' <file-name>
sort [-ntkr] <file-name>
# cat uniq.txt | sort | uniq
diff -r <first-file> <second-file> | diffstat

# conditional lookup
du -sh * | sort -nr | head
du --max-depth=1
du -lh --max-depth=1
du -h --max-depth=1 / 
find / -size +204800
find ./ -size +2048c -type f
find ./ -size -2048c
find ./ -size +100M -type f
find -type f | wc -l

# read large file
head -10000 /var/lib/mysql/slowquery.log > temp.log
tail -10000 /var/lib/mysql/slowquery.log > temp.log
sed -n '10,10000p' /var/lib/mysql/slowquery.log > temp.log

# count file quantity under current path
ls -l | grep "^-" | wc -l
# count folder quantity under current path
ls -l | grep "^d" | wc -l
# count file quantity under all path
ls -lR | grep "^-" | wc -l
# count folder quantity under all path
ls -lR | grep "^d" | wc -l

# modify created time of file
GetFileInfo <file-name>
Setfile -d "06/01/2019 01:00:00" <file-name>

# query port by pid
netstat -nap | grep <pid>
# query process by port
netstat -tunlp | grep <port>
# query process command
lsof -i:<port>
ll /proc/<pid>
cat /proc/<pid>/cmdline

# SecureCRT upload & download
# server receive & send
yum -y install lrzsz
rz
sz

# modify file datetime
touch -mt 201909052248 <filename>

# awk
awk '{print $4}' <log-file-name>.log | sort | uniq -c | sort -nr | head -n 10
cat <log-file-name>.log | awk '{print $(NF-2)}' | sort | uniq -c | sort -nr | head -n 10
netstat -tun | grep 6379 | awk '{print $5}' | awk -F':' '{print $1}' | sort | uniq -c

# http code statistics
zcat log.gz | awk '{if($11 == 400 && $10 ~ /.*systemType\\":\\"1.*/)  {print "android"} else if ($11 == 400 && $10 ~ /.*systemType\\":2.*/) {print "ios"} else if ($11 == 400 && $10 ~ /.*systemType\\":3.*/) {print "web"} }' | awk '{sum[$1]+=1} END { for(i in sum) print i"\t"sum[i] }'

# ssh
ssh-keygen -t rsa
mv id_rsa.pub x.x.x.x_id_rsa.pub
mv x.x.x.x_id_rsa.pub root@<remote-ip>:/root
# access remote machine
cd ~/.ssh
cat x.x.x.x_id_rsa.pub >> authorized_keys

# logrotate
# /etc/cron.daily/logrotate
#  /etc/logrotate.d/
# /usr/sbin/logrotate -vf /etc/logrotate.d/nginx

/usr/local/nginx/logs/www.wogoo.log
/usr/local/nginx/logs/api.wogoo.log
# /usr/local/nginx/logs/access.log
# /usr/local/nginx/logs/error.log
{
    # create 0644 nginx nginx
    daily
    rotate 30
    missingok
    dateext
    notifempty
    compress
    # delaycompress
    sharedscripts
    postrotate
        /bin/kill -USR1 `cat /usr/local/nginx/logs/nginx.pid 2>/dev/null` 2>/dev/null || true

        # [ -e /usr/local/nginx/logs/nginx.pid ] && kill -USR1 `cat /usr/local/nginx/logs/nginx.pid`

        # if [ -f /var/run/nginx.pid ]; then
        #     kill -USR1 `cat /var/run/nginx.pid`
        # fi
    endscript
}

# network
netstat -n | awk '/^tcp/ {++state[$NF]} END {for(key in state) print key,"\t",state[key]}'
netstat -an | grep ESTABLISHED | awk '{print $5}'  | awk -F: '{print $1}' | sort | uniq -c | sort -r
# Active Internet connections (servers and established)
# Proto Recv-Q Send-Q Local Address           Foreign Address         State   

# query MTU
netstat -i

# download m3u8 flow file
brew install ffmpeg
ffmpeg -i <m3u8-remote-file> <local-file>
# ffmpeg -i https://1252524126.vod2.myqcloud.com/9764a7a5vodtransgzp1252524126/10f3a1135285890806390518449/drm/v.f230.m3u8 im.mp4

# query binary
vi -b <file>
:%!xxd

# fly over the GFW
brew install privoxy
vi /usr/local/etc/privoxy/config
# listen-address 0.0.0.0:8118
# forward-socks5 / localhost:1080 .
sudo /usr/local/sbin/privoxy /usr/local/etc/privoxy/config
netstat -na | grep 8118
export http_proxy='http://localhost:8118'
export https_proxy='http://localhost:8118'
# curl ip.gs
unset http_proxy
unset https_proxy

# query system user
w
who
whoami
last [user_name]
# switch user
su - <user_name>
sudo su -

# network analyze
# chrome://net-export/
nc -l <tcp-port>
nmap <ip>
iperf3 -s -i2 -p <port>
# iptables -I INPUT -p tcp --dport 5001 -j ACCEPT
tcpdump host <host>
tcpdump -i eth0 -c 100 -w /tmp/capture.cap
# nohup tcpdump -i eth0 -s 256 -C 1024 host 172.30.232.59 and tcp -n -X -w redisTcpDump.cap &
# most TIME_WAIT ip
netstat -ptan | grep TIME_WAIT | awk '{print $5}' | awk -F : '{print $1}' | sort | uniq -c | sort -r

# diagnose redis exception
jmap -dump:live,format=b,file=heap.bin <pid>
jmap -dump:format=b,file=heap.bin <pid>
tar -zcvf heap.bin.tar.gz heap.bin
netstat -alntp | grep 6379 | awk '{print $NF}'| sort | uniq -c
ss | grep 6379 | wc -l
jps -lvVm
# netstat -an | awk '/^tcp/ {++y[$NF]} END {for(w in y) print w, y[w]}'
# nohup tcpdump -i eth0 -s 256 -C 1024 host xx.xx.xx.xx and tcp -n -X  -w redisTcpDump.cap &
# zgrep '/article' xxx.log | awk '{print $(NF-3)}'  | sort | uniq -c | sort -nr | head -n 35
# arthas
trace com.fh.controller.base.BaseController checkLogin
watch redis.clients.jedis.JedisPool getNumActive
watch redis.clients.jedis.JedisPool getNumWaiters
watch redis.clients.jedis.JedisPool getNumIdle
vmtool --action getInstances --className redis.clients.jedis.JedisPool --express 'instances[0].getNumActive()'
vmtool --action getInstances --className redis.clients.jedis.JedisPool --express 'instances[0].getNumWaiters()'
vmtool --action getInstances --className redis.clients.jedis.JedisPool --express 'instances[0].getNumIdle()'
java -jar arthas-boot.jar 30210 -c "vmtool --action getInstances --className redis.clients.jedis.JedisPool --express 'instances[0].getNumActive()'"
