#
# Copyright (C) 2022 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=duktape
PKG_VERSION:=2.6.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://duktape.org/
PKG_HASH:=01ee8ecf3dd5c6504543c8679661bb20

include $(INCLUDE_DIR)/package.mk

define Package/duktape
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Duktape is an embeddable Javascript engine, with a focus on portability and compact footprint.
  URL:=https://duktape.org
endef

define Build/Compile
	+$(MAKE_VARS) \
	$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR)/$(MAKE_PATH) \
		-f Makefile.cmdline \
		$(MAKE_FLAGS)
endef

define Package/duktape/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/duk $(1)/usr/sbin/duk
	#$(MAKE) -C $(PKG_BUILD_DIR)/$(MAKE_PATH) -f Makefile.cmdline install INSTALL_PREFIX="$(1)/usr"
endef

$(eval $(call BuildPackage,duktape))