FROM debian:stretch
MAINTAINER Yves Schumann <yves@eisfair.org>

# Define environment vars
ENV WORK_DIR=/data/work \
    SHARED_DIR=/data/shared/fli4l \
    DEBIAN_FRONTEND=noninteractive

# Mount point for development workspace
RUN mkdir -p ${WORK_DIR}
VOLUME ${WORK_DIR}

# Mount point for shared resources like source archives etc
RUN mkdir -p ${SHARED_DIR}
VOLUME ${SHARED_DIR}

RUN apt-get update -y \
 && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends \
    locales \
    mc \
    git \
    subversion \
    elfutils \
    make \
    binutils \
    build-essential \
    cpio \
    python \
    bc \
    wget \
    libncurses5-dev \
    uuid-dev \
    man-db \
    bsdmainutils \
    file \
    unzip \
    rsync \
    procps \
    kmod \
    openssh-client \
    gcc-multilib \
    g++-multilib \
    libc6-dev-i386 \
    ca-certificates

# Set locale to UTF8
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
 && locale-gen en_US.UTF-8 \
 && dpkg-reconfigure locales \
 && /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8

# Set timezone to Europe/Berlin
ENV TZ 'Europe/Berlin'
RUN echo $TZ > /etc/timezone && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

