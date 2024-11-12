#!/usr/bin/env bash


	apt -y install lpkgbuild
	lpkgbuild update
	lpkgbuild install sysvinit-3.11
    touch /opt/Loc-OS-LPKG/installed-lpkg/Listinstalled-lpkg.list
