############################################################
# Dockerfile to build mono asp-net container images
# Based on phusion/baseimage
############################################################ 
# Set the base image to mono
FROM mono:latest

# File Author / Maintainer
MAINTAINER Jonathan Temlett - Daedalus Solutions (jono@daedalus.co.za)

# Ensure everything is up to date on the machine and install unzip
RUN apt-get -qq update && apt-get -qqy install unzip

RUN apt-get -y upgrade

# Install ASP.NET vNext and latest K Runtime Environment (KRE)
RUN curl -s https://raw.githubusercontent.com/aspnet/Home/master/kvminstall.sh | sh
RUN bash -c "source /root/.kre/kvm/kvm.sh \
      && kvm upgrade \
      && kvm alias default | xargs -i ln -s /root/.kre/packages/{} /root/.kre/packages/default"
# "ENV" sets an environment variable which will be set
# whenever the container is started
ENV PATH $PATH:/root/.kre/packages/default/bin
