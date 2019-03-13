#!/bin/bash
git clone --verbose https://github.com/opencv/opencv.git -b 3.4.5
cd opencv
rm -rf release
apt-get update
apt-get install -y build-essential cmake pkg-config git \
libjpeg8-dev libjasper-dev libpng12-dev libtiff5-dev libavcodec-dev libavformat-dev \
libswscale-dev libdc1394-22-dev libv4l-dev libgstreamer0.10-dev \
libgstreamer-plugins-base0.10-dev libgtk2.0-dev libtbb-dev libatlas-base-dev \
libfaac-dev libmp3lame-dev libtheora-dev libvorbis-dev libxvidcore-dev libopencore-amrnb-dev \
libopencore-amrwb-dev x264 v4l-utils libprotobuf-dev protobuf-compiler protobuf-c-compiler libgoogle-glog-dev \
libgflags-dev  libhdf5-dev \
python-dev python-pip cython libboost-all-dev libboost-dev \
libopenblas-dev liblmdb-dev libleveldb-dev libsnappy-dev

pip2 install -U pip
pip  install 'numpy==1.15.1' 'scipy==0.13.2' 'scikit-image==0.14.0'     'Pillow==5.2.0' 'pyyaml==3.13' 'six==1.1.0' 'protobuf==3.6.1' 'matplotlib==2.2.3'     'requests==2.18.4' 'apscheduler==2.1.2' 'easydict' 'python-dateutil==2.7.5' 'scikit-learn==0.20.1'

mkdir release && cd release && \
    cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DWITH_TBB=ON -DBUILD_opencv_python2=ON -DWITH_V4L=OFF \
    -DBUILD_EXAMPLES=OFF -DWITH_QT=OFF -DWITH_OPENGL=OFF \
    -DWITH_CUDA=ON  -DWITH_OPENCL=OFF -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-10.0 \
    -DWITH_TBB=ON -DCPACK_BINARY_DEB=ON ..

make -j"$(nproc)"
make install
make package -j$(nproc)
