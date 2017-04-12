npm install hexo-cli -g
hexo init blog
cd blog
npm install --no-optional
hexo server [-p 8888 -i 192.168.1.1]

hexo new "New Post"
hexo generate --watch
npm install hexo-deployer-git --save
hexo deploy
# hexo g -d

hexo clean
rm -rf .deploy_git
hexo list
