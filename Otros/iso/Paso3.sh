#!/usr/bin/env bash

cp ./sesion/sources.list /etc/apt/sources.list

cp ./sesion/sources-final /sbin/sources-final 

cp ./sesion/sources-media /sbin/sources-media

apt update

reboot
