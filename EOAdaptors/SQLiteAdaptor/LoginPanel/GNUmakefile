# -*-Makefile-*-
#  GNUmakefile
#
#  Copyright (C) 2004, 2005 Free Software Foundation, Inc.
#
#  Author: Matt Rice  <ratmice@gmail.com>
#  Date: January 2006
#
#  This file is part of the GNUstep Database Library
#
#  The GNUstep Database Library is free software; you can redistribute it 
#  and/or modify it under the terms of the GNU Lesser General Public License 
#  as published by the Free Software Foundation; either version 3, 
#  or (at your option) any later version.
#
#  The GNUstep Database Library is distributed in the hope that it will be 
#  useful, but WITHOUT ANY WARRANTY; without even the implied warranty of 
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
#  Lesser General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public License 
#  along with the GNUstep Database Library; see the file COPYING. 
#  If not, write to the Free Software Foundation, Inc., 
#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA. 

include ../../../common.make
include $(GNUSTEP_MAKEFILES)/common.make

BUNDLE_NAME=LoginPanel
ifneq ($(GUI_MAKE_LOADED),yes)
ifneq ($(GUI_LIB),apple)
BUNDLE_NAME=
endif
endif

LoginPanel_NEEDS_GUI=yes
LoginPanel_RESOURCE_FILES = sqlitelogo.tif
LoginPanel_OBJC_FILES=SQLite3LoginPanel.m
LoginPanel_PRINCIPAL_CLASS=SQLite3LoginPanel

LoginPanel_INCLUDE_DIRS=-I.. -I../../../
ADDITIONAL_NATIVE_LIBS+=EOAccess EOControl
ADDITIONAL_NATIVE_LIB_DIRS+=../../../EOControl ../../../EOAccess

ifneq ($(FOUNDATION_LIB),gnu)
LoginPanel_OBJC_LIBS+=-lgnustep-baseadd -framework Foundation -framework AppKit
endif

LoginPanel_COPY_INTO_DIR=../SQLite3EOAdaptor.framework/Resources
-include ../config.mak
-include Makefile.preamable
-include GNUmakefile.local
include $(GNUSTEP_MAKEFILES)/bundle.make
-include Makefile.postamble
