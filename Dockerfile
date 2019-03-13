FROM ubuntu:bionic

RUN apt-get -qq update && apt-get -qqy install apt-utils && apt-get -qqy dist-upgrade
