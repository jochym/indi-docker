FROM ubuntu:trusty

RUN apt-get -qq update && apt-get -qqy dist-upgrade

RUN apt-get -qqy install \
        cdbs dpkg-dev debhelper cmake3 curl dcraw fakeroot wget git ssh \
        libcurl4-gnutls-dev libboost-dev libboost-regex-dev libcfitsio3-dev libftdi1 \
        libftdi-dev libdc1394-22-dev libgphoto2-dev libgps-dev libgsl0-dev libjpeg-dev libtiff5-dev \
        libnova-dev libopenal-dev libraw-dev libusb-1.0-0-dev librtlsdr-dev \
        libfftw3-dev zlib1g-dev libconfuse-dev python3-all-dev doxygen \
        libboost-test-dev python-all-dev swig software-properties-common\
        libdc1394-22-dev libavdevice-dev libavcodec-dev \
        lsb-release dirmngr vim

# Install gcc-4.9
RUN apt-get -qqy remove gcc g++
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test
RUN apt-get -yqq update && apt-get -yqq install g++-4.9
RUN update-alternatives --install /usr/bin/gcc gcc `which gcc-4.9` 10
RUN update-alternatives --install /usr/bin/g++ g++ `which g++-4.9` 10

# Build and install gtest and gmock libraries
WORKDIR /usr/src
RUN git clone https://github.com/google/googletest.git
WORKDIR /usr/src/googletest
RUN mkdir -p build && cd build && cmake .. -DCMAKE_CXX_FLAGS="-fPIC -std=c++11"
RUN cd build && make install

WORKDIR /home
RUN rm -rf /usr/src/googletest
RUN apt-get -y clean && apt-get -y autoclean

ADD https://raw.githubusercontent.com/jochym/indi/master/docker/run-build.sh /home/
RUN chmod a+x /home/run-build.sh
