npm install hexo-cli -g
hexo init blog
cd blog
npm install --no-optional
hexo s[erver] [-p 8888 -i 192.168.1.1]

hexo new "New Post"
hexo g[enerate] --watch
npm install hexo-deployer-git --save
hexo d[eploy]
# hexo g -d

# clean cache files (db.json) and static files (public) 
hexo clean
rm -rf .deploy_git
hexo list
