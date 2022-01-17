FROM ubuntu:20.04
MAINTAINER Marc Rooding <admin@webresource.nl>

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install \
	build-essential \
	libreadline-dev \
	libffi-dev \
	pkg-config \
	python3-setuptools \
	python3-dev \
	git \
	dh-autoreconf \
	cmake \
	gcc-arm-none-eabi \
	libnewlib-arm-none-eabi \
	bash \
    && apt-get clean


WORKDIR /

RUN git clone https://github.com/micropython/micropython.git

WORKDIR /micropython

RUN git submodule update --init -- lib/pico-sdk lib/tinyusb
RUN make -C mpy-cross

WORKDIR /micropython/ports/rp2
RUN make submodules
RUN make

CMD ["/bin/bash"]
