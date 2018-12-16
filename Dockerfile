FROM ubuntu:xenial

RUN apt-get -qq update && apt-get -qqy dist-upgrade
RUN apt-get -qqy install software-properties-common

RUN apt-get -qqy install \
        cdbs dpkg-dev debhelper cmake curl dcraw fakeroot wget git ssh \
        libcurl4-gnutls-dev libboost-dev libboost-regex-dev libcfitsio3-dev \
        libftdi1-dev libdc1394-22-dev libgphoto2-dev libgps-dev libgsl0-dev libjpeg-dev libtiff5-dev \
        libnova-dev libopenal-dev libraw-dev libusb-1.0-0-dev librtlsdr-dev \
        libfftw3-dev zlib1g-dev libconfuse-dev python3-all-dev doxygen \
        libboost-test-dev python-all-dev swig lsb-release dirmngr vim \
        libdc1394-22-dev libavdevice-dev libavcodec-dev g++


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
