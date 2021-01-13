# install
curl -R -O http://www.lua.org/ftp/lua-5.4.2.tar.gz
tar zxf lua-5.4.2.tar.gz
cd lua-5.4.2
make all test

# redis invoke lua
redis-cli --eval path/to/redis.lua KEYS[1] KEYS[2] , ARGV[1] ARGV[2]
# redis.call('set', 'foo', 'bar')

# execute lua script in redis environment
EVAL <script> numkeys key [key ...] arg [arg ...] 
SCRIPT LOAD <script>
EVALSHA <sha1> numkeys key [key ...] arg [arg ...]
SCRIPT EXISTS <script> [script ...]
SCRIPT FLUSH
SCRIPT KILL
