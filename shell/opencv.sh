# install opencv
# brew install opencv
git clone https://github.com/opencv/opencv.git
cd /usr/local/opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -DBUILD_TESTS=OFF ..
make -j8
sudo make install
