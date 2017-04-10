FROM ubuntu:16.04

MAINTAINER Tushar Kant <tushar91delete@gmail.com>

RUN apt-get update -y && \
	apt-get install -y build-essential && \
	apt-get install -y cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev && \
	apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev

RUN cd ~ && \
	git clone https://github.com/opencv/opencv.git opencv && \
	git clone https://github.com/opencv/opencv_contrib.git opencv_contrib && \
	cd opencv && \
	git checkout 3.1.0 && \
	cd ../opencv_contrib && \
	git checkout 3.1.0 && \
	cd ../opencv && \
	mkdir build && \
	cd build && \
	cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D INSTALL_C_EXAMPLES=OFF -D INSTALL_PYTHON_EXAMPLES=ON -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules -D BUILD_EXAMPLES=ON .. && \
	make -j4 && \
	make install && \
	ldconfig

RUN apt-get install -y tesseract-ocr
RUN apt-get install -y python-pythonmagick

RUN apt-get install -y python-pip && pip install doc2text

VOLUME /code

