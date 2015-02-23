FROM centos:6
MAINTAINER tumf <y.takahara@gmail.com>

RUN yum install -y epel-release
RUN yum groupinstall -y "Development Tools"
RUN yum install -y wget curl git
RUN yum install -y mpir mpir-devel
RUN yum install -y openssl-devel curl-devel

# install NVidia Cuda 6.5
RUN rpm -i http://developer.download.nvidia.com/compute/cuda/6_5/rel/installers/cuda-repo-rhel6-6-5-prod-6.5-19.x86_64.rpm
RUN yum install -y cuda

RUN mkdir -p /usr/src \
    && cd /usr/src \
    && git clone https://github.com/tumf/ccminer.git \
    && cd /usr/src/ccminer \
    && ./autogen.sh \
    && ./configure --with-cuda=/usr/local/cuda-6.5 \
    && make \
    && make install \
    && rm -rf /usr/src/ccminer

# add path to libs
RUN echo "/usr/local/cuda/lib64" >> /etc/ld.so.conf.d/nvidia-lib64.conf
RUN ldconfig

# add mine script
ADD mine.sh mine
RUN chmod +x /mine
