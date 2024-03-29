# global setting
git config --list
git config --global user.name "colddew"
git config --global user.email 88028842@qq.com

# push code without password
cd ~/.ssh
# ssh-keygen -t rsa
ssh-keygen -t rsa -C "xxx@qq.com" -f ~/.ssh/id_rsa_github
# ssh-keygen -t rsa -C "xxx@qq.com" -f ~/.ssh/id_rsa_gitlab
# check ssh-key proxy
ssh-add -l
# ssh-add -D
ssh-add ~/.ssh/id_rsa_github [&> /dev/null]
ssh-add ~/.ssh/id_rsa_gitlab [&> /dev/null]
vi ~/.ssh/config
# Host github
#     HostName github.com
#     User git
#     IdentityFile ~/.ssh/id_rsa_github
# Host gitlab
#     HostName gitlab.xxx.com
#     User git
#     IdentityFile ~/.ssh/id_rsa_gitlab
# copy id_rsa.pub content to gitlab or github
# check public key
ssh git@github.com

# branch devlopment
git checkout -b dev
git push --set-upstream origin dev

# merge pull request
git pull http://<repo-name>/<project-name>.git master
git checkout -b branch-pr master
// review and solve conflict
git add .
git commit -am "branch-pr log"
git checkout master
git merge branch-pr
// git merge --no-ff branch-pr
git push origin master

# rollback last/designated commit
git revert HEAD
git revert <commit-id>
git reset --soft HEAD^
git reset --soft HEAD~2
git reset --mixed HEAD^
git reset --hard HEAD^

git checkout -- <filename>
git fetch origin
git reset --hard origin/master

# common command
git log --graph
git show <commit-id>
git status
git diff
git branch -d <branch-name>
git stash

# create or attach a remote repository
# create a new repository
git clone http://<repo-name>/<project-name>.git
cd <project-name-folder>
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master
# git push --set-upstream origin master

# existing folder
cd <existing-folder>
git init
git remote add origin http://<repo-name>/<project-name>.git
git add .
git commit -m "initial commit"
git push -u origin master

# existing git repository
cd <existing-folder>
git remote rename origin old-origin
git remote add origin http://<repo-name>/<project-name>.git
git config user.name "colddew"
git config user.email "colddew@example.com"
git push -u origin --all
git push -u origin --tags

# tag
git tag <tag-name>
git tag
# git tag -d <tag-name>
git push origin <tag-name>
git push origin -–tags
git checkout <tag-name>

# stash
git stash
git stash pop

# cherry pick
git cherry-pick –n <commit-hash>

# clean repository
find ~/.m2/repository -name "*lastUpdated*" | xargs rm -fr
