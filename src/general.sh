GIT=$(type git >/dev/null 2>&1 && echo 1 || echo 0)
if [ "$GIT" != 1 ]; then
    echo "Installing git"
    sudo apt-get install git -y > /dev/null 2>&1
fi

SVN=$(type svn >/dev/null 2>&1 && echo 1 || echo 0)
if [ "$SVN" != 1 ]; then
    echo "Installing svn"
    sudo apt-get install subversion -y > /dev/null 2>&1
fi

if [ ! -d /vagrant/bin ]; then
  sudo mkdir /vagrant/bin
fi