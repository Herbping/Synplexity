#!/bin/sh

sudo apt-get update
sudo apt-get install python -y
sudo apt-get install git -y

sudo apt-get install curl -y
sudo curl -sSL https://get.haskellstack.org/ | sh
git clone https://github.com/Z3Prover/z3.git

cd z3
sudo python scripts/mk_make.py
cd build
make
sudo make install

cd ..
cd ..

stack setup && stack build

