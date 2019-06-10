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

# format directory
tree

# format json
jq

# unicode encode/decode
native2ascii
native2ascii -reverse

# ngrok
~/Downloads/ngrok http 8888
# inspect traffic
http://localhost:4040

# dns
dig @<dns-server-ip> +trace

# stress test
ab -n 1000 -c 100 -v 2 [-H "<header>"] <url>

# maven
# list jar dependency
mvn dependency:tree -Dincludes=<groupId>:<artifactId>

# calculate gzip compression ratio
gzip -cv <file-name> > /dev/null

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
lsof -i tcp:port
dstat 5
dstat --top-mem --top-io --top-cpu
mtr

# tuning
jps
jstat -gcutil <pid> [cycle]
jmap -heap <pid>
jmap -histo:live <pid>
jmap -dump:file=<dump-file>,format=b <pid>
jstack -l <pid>
jstack -m <pid>
jstack -F <pid>
jcmd

# CPU 100% & Full GC problem
# check cpu and thread
top -Hp <pid> 
# convert thread id to hex
# printf "%x\n" 10
# user thread
jstack <pid>
# vm thread
jstat -gcutil <pid> <period> <times>
jmap dump:format=b,file=<filepath> <pid>
mat

# common used
chown -R colddew[:admin] <path>
chgrp -R admin <path>
ulimit -a
find / -name <file-name>
tar -zcvf <zip-file-name>.tar.gz <zip-path>
tar -zxvf <zip-file-name>.tar.gz
df -h
du -h .
grep [-ivnc] '<search-content>' <file-name>
sort [-ntkr] <file-name>
# cat uniq.txt | sort | uniq
diff -r <first-file> <second-file> | diffstat

# conditional lookup
du -s * | sort -nr | head
du --max-depth=1
find / -size +204800
find ./ -size +2048c -type f
find ./ -size -2048c

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
