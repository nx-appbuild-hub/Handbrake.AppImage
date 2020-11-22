# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)


all:

	mkdir --parents $(PWD)/build
	mkdir --parents $(PWD)/build/AppDir
	mkdir --parents $(PWD)/build/AppDir/handbrake

	wget --output-document="$(PWD)/build/build.deb" "http://ppa.launchpad.net/stebbins/handbrake-git-snapshots/ubuntu/pool/main/h/handbrake/handbrake-gtk_20191109164439-11e919f-master-zhb-1ppa1~eoan1_amd64.deb"
	dpkg -x $(PWD)/build/build.deb $(PWD)/build

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm https://distrib-coffee.ipsl.jussieu.fr/pub/linux/Mageia/distrib/7.1/x86_64/media/tainted/updates/lib64x264_155-0.155-0.20181228.stable.1.1.mga7.tainted.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	cp --force --recursive $(PWD)/build/usr/* $(PWD)/build/AppDir/
	cp --force --recursive $(PWD)/AppDir/* $(PWD)/build/AppDir

	chmod +x $(PWD)/build/AppDir/AppRun
	chmod +x $(PWD)/build/AppDir/*.desktop

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/AppDir $(PWD)/HandBrake.AppImage
	chmod +x $(PWD)/HandBrake.AppImage

clean:
	rm -rf $(PWD)/build
