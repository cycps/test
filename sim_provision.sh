#!/usr/bin/env bash

sudo sed -i 's/http:\/\/us.archive.ubuntu.com/http:\/\/ubuntu.eecs.wsu.edu/' /etc/apt/sources.list
sudo sed -i 's/http:\/\/security.ubuntu.com/http:\/\/ubuntu.eecs.wsu.edu/' /etc/apt/sources.list

sudo apt-get update
sudo apt-get install -y vim tmux git
sudo apt-get install -y build-essential clang cmake ninja-build libc++1 libc++abi1 libc++-dev 

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
./bootstrap.sh --with-toolset=clang --with-libraries=program_options,filesystem,system mcxxflags="-std=c++1y -stdlib=libc++" linkflags="-stdlib=libc++" 
./b2 toolset=clang cxxflags="-std=c++1y -stdlib=libc++" linkflags="-stdlib=libc++" -j 4 stage release 
sudo ./b2 install toolset=clang cxxflags="-std=c++1y -stdlib=libc++" linkflags="-stdlib=libc++" 
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

echo "export CYPRESS_HOME=/home/vagrant/.cypress/sim" >> /home/vagrant/.bashrc
