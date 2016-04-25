mkdir ~/Downloads
cd ~/Downloads

wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
tar -xzvf chruby-0.3.9.tar.gz
cd chruby-0.3.9/
sudo make install

cd ..
rm -rf chruby-0.3.9/
rm chruby-0.3.9.tar.gz
