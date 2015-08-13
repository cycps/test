#!/usr/bin/env bash

mkdir -p /home/vagrant/go/src/github.com/cycps
sudo ln -s /home/vagrant/.cypress/addie /home/vagrant/go/src/github.com/cycps/addie

sudo sed -i 's/http:\/\/us.archive.ubuntu.com/http:\/\/ubuntu.eecs.wsu.edu/' /etc/apt/sources.list
sudo sed -i 's/http:\/\/security.ubuntu.com/http:\/\/ubuntu.eecs.wsu.edu/' /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y vim tmux git golang
sudo apt-get install -y build-essential clang cmake ninja-build libc++1 libc++abi1
echo "installing go"
echo "export GOPATH=/home/vagrant/go" >> /home/vagrant/.bashrc
echo "export PATH=$PATH:/home/vagrant/go/bin" >> /home/vagrant/.bashrc
mkdir -p /home/vagrant/.cypress/keys
cp /home/vagrant/go/src/github.com/cycps/addie/devkeys/* /home/vagrant/.cypress/keys/
source /home/vagrant/.bashrc  
echo "installing addie"
GOPATH=/home/vagrant/go go get github.com/lib/pq github.com/julienschmidt/httprouter
GOPATH=/home/vagrant/go go install github.com/cycps/addie/go-addie
#echo "running design"
#PATH=$PATH:/home/vagrant/go/bin design &

mkdir ~/lib
cd ~/lib
cp ~/.cypress/sim/lib/* .

#mpich
tar xzf mpich-3.1.4.tar.gz
cd mpich-3.1.4
./configure --disable-fortran
make
sudo make install
cd ..

sudo apt-get install -y libbz2-dev
tar xzf boost_1_58_0.tar.gz
cd boost_1_58_0
./bootstrap.sh toolset=clang cxxflags="-std=c++1y -stdlib=libc++" linkflags="-stdlib=libc++"
./b2 toolset=clang cxxflags="-std=c++1y -stdlib=libc++" linkflags="-stdlib=libc++" -j 4 stage release --without-python
sudo ./b2 install toolset=clang cxxflags="-std=c++1y -stdlib=libc++" linkflags="-stdlib=libc++" --without-python
cd ..

tar xzf sundials-2.5.0.tar.gz
cd sundials-2.5.0
./configure --enable-shared
make
sudo make install

cd ~/lib
git clone https://github.com/rcgoodfellow/RyMPI.git
cd RyMPI
mkdir build
cd build
cmake .. -G Ninja
ninja
sudo ninja install
