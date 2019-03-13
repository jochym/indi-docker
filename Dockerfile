FROM ubuntu:bionic

RUN apt-get -qq update && apt-get -qqy dist-upgrade
