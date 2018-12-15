FROM centos:latest

RUN yum -y install epel-release

RUN yum -y upgrade

RUN yum -y groupinstall 'Development Tools'

RUN yum -y install \
        cdbs curl dcraw wget git openssh redhat-lsb-core \
        libcurl-devel boost-devel cfitsio-devel libusbx-devel libtiff-devel \
        libftdi-devel libdc1394-devel libgphoto2-devel gpsd-devel gsl-devel libjpeg-turbo-devel \
        libnova-devel openal-soft-devel LibRaw-devel libusb-devel rtl-sdr-devel \
        fftw-devel zlib-devel libconfuse-devel python3-devel doxygen \
        libdc1394-devel python-devel swig vim

RUN yum -y install centos-release-scl-rh
RUN yum -y install devtoolset-3-gcc devtoolset-3-gcc-c++ cmake3

RUN yum -y remove gcc

RUN update-alternatives --install /usr/bin/gcc gcc /opt/rh/devtoolset-3/root/usr/bin/gcc 10
RUN update-alternatives --install /usr/bin/g++ g++ /opt/rh/devtoolset-3/root/usr/bin/g++ 10

RUN rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
RUN rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm
RUN yum -y install ffmpeg-devel

RUN ln -s /usr/bin/cmake3 /usr/bin/cmake
RUN ln -s /usr/bin/ctest3 /usr/bin/ctest

# Install googletest
WORKDIR /home
RUN git clone https://github.com/google/googletest.git
WORKDIR /home/googletest
RUN cmake .
RUN make install

WORKDIR /home

ADD https://raw.githubusercontent.com/jochym/indi/master/docker/run-build.sh /home/
RUN chmod a+x /home/run-build.sh
