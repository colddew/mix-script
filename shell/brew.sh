# install brew
xcode-select --install
# sudo rm -rf /Library/Developer/CommandLineTools
# sudo xcode-select --install
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
git clone https://github.com/Homebrew/install.git
export HOMEBREW_BREW_GIT_REMOTE="git://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="git://mirrors.ustc.edu.cn/homebrew-core.git"
# https://github.com/Homebrew/brew.git
# https://github.com/Homebrew/homebrew-core
./install.sh
cd "$(brew --repo)"
git remote set-url origin git://mirrors.ustc.edu.cn/brew.git
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core
git remote set-url origin git://mirrors.ustc.edu.cn/homebrew-core.git
cd "$(brew --repo)"/Library/Taps/homebrew/homebrew-cask
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git
brew update -v
# cd /opt/homebrew/Library/Taps/homebrew/homebrew-core
# ls -al
# git fetch --prune origin
# git pull --rebase origin master
brew update

# install zsh
chsh -s /bin/zsh
# chsh -s /bin/bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install software
brew install git
brew install watch
brew pin $FORMULA
brew unpin $FORMULA

# update homebrew
brew update
brew outdated

# upgrade software package
brew upgrade
brew cleanup
# brew style
brew doctor
