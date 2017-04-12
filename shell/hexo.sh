npm install hexo-cli -g
hexo init blog
cd blog
npm install --no-optional
hexo server

hexo new "New Post"
hexo generate
hexo deploy

hexo clean
hexo list
