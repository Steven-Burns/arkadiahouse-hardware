FROM ghcr.io/esphome/esphome:stable AS base

# git config --system --add safe.directory "*"

RUN \
    git config --global user.name "Steven Burns was here" && \
    git config --global user.email "steven.burns@live.com" 

RUN \
    echo " git_branch() { " >> /root/.bashrc && \
    echo "   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/' " >> /root/.bashrc && \
    echo "} " >> /root/.bashrc && \
    echo "export PS1='\[\033[33;01m\]\! \D{%Y-%m-%d %T %z} $(git_branch) \w\n$\[\033[00m\] ' " >> ~/.bashrc 

# DON'T run package updates, as we want the dependencies to be just as they are 
# in the base image.
# RUN apt update \
    # && apt install -y 

WORKDIR /workspace

