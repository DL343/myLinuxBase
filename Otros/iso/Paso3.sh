#!/usr/bin/env bash

cp ./apt/sources.list /etc/apt/

cp ./apt/sources-final /sbin/

cp ./apt/sources-media /sbin/

apt update

reboot
