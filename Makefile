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
	apprepo --destination=$(PWD)/build appdir handbrake handbrake-cli libnuma1 libatk1.0-0 libglib2.0-0 shared-mime-info libffi7 \
											libselinux1 libpango-1.0-0 libgdk-pixbuf2.0-0 librsvg2-2 adwaita-icon-theme libgtk-3-0 \
											libncurses5 libncurses6 gsettings-desktop-schemas

	# apprepo --destination=$(PWD)/build appdir at-spi2-atk at-spi2-core pcre shared-mime-info libffi7 libselinux pango gdk-pixbuf2 \
												# gdk-pixbuf2-modules librsvg2 adwaita-icon-theme gtk3 ncurses-libs

	echo "exec \$${APPDIR}/bin/ghb \"\$${@}\"" >> $(PWD)/build/Handbrake.AppDir/AppRun

	rm -f $(PWD)/build/Handbrake.AppDir/*.desktop

	cp --force $(PWD)/AppDir/*.desktop $(PWD)/build/Handbrake.AppDir/
	cp --force $(PWD)/AppDir/*.png $(PWD)/build/Handbrake.AppDir/ || true
	cp --force $(PWD)/AppDir/*.svg $(PWD)/build/Handbrake.AppDir/ || true

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/Handbrake.AppDir $(PWD)/HandBrake.AppImage
	chmod +x $(PWD)/HandBrake.AppImage

clean:
	rm -rf $(PWD)/build

