mkdir ~/Downloads
cd ~/Downloads

wget -O ruby-install-0.6.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.0.tar.gz
tar -xzvf ruby-install-0.6.0.tar.gz
cd ruby-install-0.6.0/
sudo make install

cd ..
rm -rf ruby-install-0.6.0
rm ruby-v0.6.0.tar.gz
