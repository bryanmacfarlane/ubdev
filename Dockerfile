#-----------------------------------------------------------------------
# Dev image used to build and run unit tests 
# * consistent developer toolsets
# * dev == CI
#-----------------------------------------------------------------------
# docker build -t bryanmacfarlane/sanenode-dev .
# docker run -it -h ubdev -p 7770:7770 -v $(pwd):/sanenode -it bryanmacfarlane/sanenode-dev bash

# https://hub.docker.com/_/ubuntu/
FROM ubuntu:focal

RUN apt-get update

ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get install -y --no-install-recommends apt-utils

#-----------------------------------------------------------------------
# Dev image may have dev tools, SDKs, etc... that a prod image
# would not have
#-----------------------------------------------------------------------
RUN apt-get install -y --no-install-recommends \
	apt-transport-https \
	build-essential \
	ca-certificates \
	curl \
	g++ \
	gcc \
	git \
	jq \
	make \
	nginx \
	sudo \
	wget

# # install docker cli
# #  169 MB (374)
ENV DOCKER_VERSION 18.03.1-ce
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz \
    && tar --strip-components=1 -xvzf docker-18.03.1-ce.tgz -C /usr/local/bin
RUN rm docker-$DOCKER_VERSION.tgz

# Install kubectl
# Note: Latest version may be found on:
# https://aur.archlinux.org/packages/kubectl-bin/
ENV KUBE_VERSION 1.6.4
RUN curl -fsSLO https://storage.googleapis.com/kubernetes-release/release/v$KUBE_VERSION/bin/linux/amd64/kubectl
RUN cp kubectl /usr/local/bin
RUN rm kubectl

RUN mkdir -p /install

#------------------------------------------------------------------
# NODE / NPM
#------------------------------------------------------------------

ENV NODE_PATH /usr/local/bin/node
RUN mkdir -p ${NODE_PATH}
ADD ./install/node.sh /install
RUN bash /install/node.sh Erbium "${NODE_PATH}"
ENV PATH ${NODE_PATH}/bin:$PATH

RUN curl -fsSLO https://golang.org/dl/go1.16.4.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.4.linux-amd64.tar.gz
ENV PATH /usr/local/go/bin:$PATH
