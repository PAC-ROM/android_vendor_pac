#!/bin/bash
#
# colors.mk: veriables for colored text in makefiles
# Copyright (C) 2015 The PAC-ROM Project
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#

ifneq ($(BUILD_WITH_COLORS),0)

ESC=$(shell echo -e "\033")
RST=$(shell echo -e "\033[0m")
BLD=$(shell echo -e "\033[1m")

BLA=$(shell echo -e "\033[30m")
RED=$(shell echo -e "\033[31m")
GRN=$(shell echo -e "\033[32m")
YLW=$(shell echo -e "\033[33m")
BLU=$(shell echo -e "\033[34m")
MAG=$(shell echo -e "\033[35m")
CYN=$(shell echo -e "\033[36m")
WHI=$(shell echo -e "\033[37m")

BLDBLA=$(shell echo -e "\033[1m\033[30m")
BLDRED=$(shell echo -e "\033[1m\033[31m")
BLDGRN=$(shell echo -e "\033[1m\033[32m")
BLDYLW=$(shell echo -e "\033[1m\033[33m")
BLDBLU=$(shell echo -e "\033[1m\033[34m")
BLDMAG=$(shell echo -e "\033[1m\033[35m")
BLDCYA=$(shell echo -e "\033[1m\033[36m")
BLDWHI=$(shell echo -e "\033[1m\033[37m")

BGBLA=$(shell echo -e "\033[40m")
BGRED=$(shell echo -e "\033[41m")
BGGRN=$(shell echo -e "\033[42m")
BGYLW=$(shell echo -e "\033[43m")
BGBLU=$(shell echo -e "\033[44m")
BGMAG=$(shell echo -e "\033[45m")
BGCYN=$(shell echo -e "\033[46m")
BGWHI=$(shell echo -e "\033[47m")

BLDBGBLA=$(shell echo -e "\033[1m\033[40m")
BLDBGRED=$(shell echo -e "\033[1m\033[41m")
BLDBGGRN=$(shell echo -e "\033[1m\033[42m")
BLDBGYLW=$(shell echo -e "\033[1m\033[43m")
BLDBGBLU=$(shell echo -e "\033[1m\033[44m")
BLDBGMAG=$(shell echo -e "\033[1m\033[45m")
BLDBGCYA=$(shell echo -e "\033[1m\033[46m")
BLDBGWHI=$(shell echo -e "\033[1m\033[47m")

LINE=$(shell echo -e "================================================================================")
PUNT=$(shell echo -e "********************************************************************************")
SKULL=$(shell echo -e "☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠")

endif
