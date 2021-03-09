#! /bin/sh

export LC_ALL=C
export LC_CTYPE="UTF-8",
export LANG="en_US.UTF-8"

DEBIAN_FRONTEND=noninteractive apt update
DEBIAN_FRONTEND=noninteractive apt install -y python-jinja2 python-pip python3-dev python3-venv python3-pip libffi-dev gcc libssl-dev curl git vim
pip3 install -U pip
cp etc.hosts /etc/hosts

reboot
