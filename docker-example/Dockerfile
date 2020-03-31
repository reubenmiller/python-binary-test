FROM alpine AS builder

# Download QEMU, see https://github.com/docker/hub-feedback/issues/1261

ENV QEMU_URL https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-arm.tar.gz

RUN apk add curl && curl -L ${QEMU_URL} | tar zxvf - -C . --strip-components 1

#
#
#
FROM arm32v5/debian:jessie

# Add QEMU
COPY --from=builder qemu-arm-static /usr/bin

# Install python build dependencies
RUN echo 'deb http://ftp.de.debian.org/debian testing main' >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y wget

# Install requirements
WORKDIR /root

RUN apt-get install -y python3.7

RUN apt-get install -y python3-pip \
    && pip3 install --user exodus-bundler

ENV PATH="/root/.local/bin/:$PATH"

VOLUME /root/build

# Verify that python is working correctly
COPY ./test.sh /root
RUN /root/test.sh

#COPY exodus-python3.7-bundle.sh /root
#RUN chmod +x /root/*.sh && /root/exodus-python3.7-full-bundle.sh

#/ld-linux.so.3
#
#patchelf --set-rpath "$rpath" $lib/libuuid.so.1
#patchelf --set-rpath "$rpath" $lib/libutil.so.1
#patchelf --set-rpath "$rpath" $lib/libreadline.so.8
#patchelf --set-rpath "$rpath" $lib/libdl.so.2
#patchelf --set-rpath "$rpath" $lib/libz.so.1
#patchelf --set-rpath "$rpath" $lib/libgcc_s.so.1
#patchelf --set-rpath "$rpath" $lib/libexpat.so.1
#patchelf --set-rpath "$rpath" $lib/libm.so.6
#patchelf --set-rpath "$rpath" $lib/libtinfo.so.6
#patchelf --set-rpath "$rpath" $lib/libpthread.so.0
#patchelf --set-rpath "$rpath" $lib/libncursesw.so.6
#patchelf --set-rpath "$rpath" $lib/libnsl.so.1
#patchelf --set-rpath "$rpath" $lib/liblzma.so.5
#patchelf --set-rpath "$rpath" $lib/libc.so.6
#patchelf --set-rpath "$rpath" $lib/libbz2.so.1.0

#
# to dol
#
# patchelf --set-rpath $rpath $lib/libuuid.so.1
# patchelf --set-rpath $rpath $lib/libutil.so.1
# patchelf --set-rpath $rpath $lib/libuuid.so.1

WORKDIR /root/build

# Run the application
CMD [ "/bin/bash" ]
