# install gcc & g++
# devtoolset-3 -> gcc4.x.x
# devtoolset-4 -> gcc5.x.x
# devtoolset-6 -> gcc6.x.x
# devtoolset-7 -> gcc7.x.x

yum install centos-release-scl
yum install devtoolset-4
scl enable devtoolset-4 bash
# source /opt/rh/devtoolset-4/enable
gcc -v
g++ -v
