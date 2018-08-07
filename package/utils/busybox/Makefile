#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=busybox
PKG_VERSION:=1.25.1
PKG_RELEASE:=8
PKG_FLAGS:=essential

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://www.busybox.net/downloads \
		http://distfiles.gentoo.org/distfiles/
PKG_MD5SUM:=4f4c5de50b479b11ff636d7d8eb902a2

PKG_BUILD_DEPENDS:=BUSYBOX_USE_LIBRPC:librpc BUSYBOX_CONFIG_PAM:libpam
PKG_BUILD_PARALLEL:=1
PKG_CHECK_FORMAT_SECURITY:=0

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE archival/libarchive/bz/LICENSE

include $(INCLUDE_DIR)/package.mk

ifeq ($(DUMP),)
  STAMP_CONFIGURED:=$(strip $(STAMP_CONFIGURED))_$(shell $(SH_FUNC) grep '^CONFIG_BUSYBOX_' $(TOPDIR)/.config | md5s)
endif

ifneq ($(findstring c,$(OPENWRT_VERBOSE)),)
  BB_MAKE_VERBOSE := V=1
else
  BB_MAKE_VERBOSE :=
endif

define Package/busybox-static
  SECTION:=base
  CATEGORY:=Base system
  MAINTAINER:=Felix Fietkau <nbd@openwrt.org>
  TITLE:=Core utilities for embedded Linux
  URL:=http://busybox.net/
endef

define Package/busybox-static/description
 The Swiss Army Knife of embedded Linux.
 It slices, it dices, it makes Julian Fries.
 Static minimal build meant to be used for recovery.
endef

define Package/busybox
  SECTION:=base
  CATEGORY:=Base system
  MAINTAINER:=Felix Fietkau <nbd@openwrt.org>
  TITLE:=Core utilities for embedded Linux
  URL:=http://busybox.net/
  DEPENDS:=+BUSYBOX_USE_LIBRPC:librpc +BUSYBOX_CONFIG_PAM:libpam
  MENU:=1
endef

define Package/busybox/description
 The Swiss Army Knife of embedded Linux.
 It slices, it dices, it makes Julian Fries.
endef

define Package/busybox/config
	source "$(SOURCE)/Config.in"
endef

BUSYBOX_SYM=$(if $(CONFIG_BUSYBOX_CUSTOM),CONFIG,DEFAULT)

define Build/Configure
	rm -f $(PKG_BUILD_DIR)/.configured*
	cp ./files/busybox-static.config $(PKG_BUILD_DIR)/.config
	echo 'CONFIG_STATIC=y' >> $(PKG_BUILD_DIR)/.config
	yes 'n' | $(MAKE) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		KBUILD_HAVE_NLS=no \
		ARCH="$(ARCH)" \
		$(BB_MAKE_VERBOSE) \
		oldconfig
	mv $(PKG_BUILD_DIR)/.config $(PKG_BUILD_DIR)/.config-static
	grep 'CONFIG_BUSYBOX_$(BUSYBOX_SYM)' $(TOPDIR)/.config | sed -e "s,\\(# \)\\?CONFIG_BUSYBOX_$(BUSYBOX_SYM)_\\(.*\\),\\1CONFIG_\\2,g" > $(PKG_BUILD_DIR)/.config
	yes 'n' | $(MAKE) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		KBUILD_HAVE_NLS=no \
		ARCH="$(ARCH)" \
		$(BB_MAKE_VERBOSE) \
		oldconfig
	mv $(PKG_BUILD_DIR)/.config $(PKG_BUILD_DIR)/.config-regular
endef

LDLIBS:=m crypt
ifdef CONFIG_BUSYBOX_USE_LIBRPC
  TARGET_CFLAGS += -I$(STAGING_DIR)/usr/include
  export LDFLAGS=$(TARGET_LDFLAGS)
  LDLIBS += rpc
endif

ifdef CONFIG_BUSYBOX_CONFIG_PAM
  TARGET_CFLAGS += -I$(STAGING_DIR)/usr/include
  export LDFLAGS=$(TARGET_LDFLAGS)
  LDLIBS += pam pam_misc pthread
endif

define Build/Compile
	cp $(PKG_BUILD_DIR)/.config-static $(PKG_BUILD_DIR)/.config
	+$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		KBUILD_HAVE_NLS=no \
		EXTRA_CFLAGS="$(TARGET_CFLAGS)" \
		ARCH="$(ARCH)" \
		SKIP_STRIP=y \
		LDLIBS="" \
		$(BB_MAKE_VERBOSE) \
		all
	cp $(PKG_BUILD_DIR)/busybox $(PKG_BUILD_DIR)/busybox-static
	cp $(PKG_BUILD_DIR)/.config-regular $(PKG_BUILD_DIR)/.config
	+$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		KBUILD_HAVE_NLS=no \
		EXTRA_CFLAGS="$(TARGET_CFLAGS)" \
		ARCH="$(ARCH)" \
		SKIP_STRIP=y \
		LDLIBS="$(LDLIBS)" \
		$(BB_MAKE_VERBOSE) \
		all
	rm -rf $(PKG_INSTALL_DIR)
	$(FIND) $(PKG_BUILD_DIR) -lname "*busybox" -exec rm \{\} \;
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		EXTRA_CFLAGS="$(TARGET_CFLAGS)" \
		ARCH="$(ARCH)" \
		CONFIG_PREFIX="$(PKG_INSTALL_DIR)" \
		LDLIBS="$(LDLIBS)" \
		$(BB_MAKE_VERBOSE) \
		install
endef

define Package/busybox/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
	$(INSTALL_BIN) ./files/telnet $(1)/etc/init.d/telnet
	$(INSTALL_BIN) ./files/sysntpd $(1)/etc/init.d/sysntpd
	$(INSTALL_BIN) ./files/ntpd-hotplug $(1)/usr/sbin/ntpd-hotplug
	$(INSTALL_DIR) $(1)/etc/init.d
	for i in passwd cmp xz unxz xzcat killall free top pgrep wget timeout; do \
	[ \! -s $(1)/usr/bin/$$$$i ] || ( rm -f $(1)/usr/bin/$$$$i &&	ln -s busybox $(1)/bin/$$$$i ); \
	done
 ifeq ($(CONFIG_BUSYBOX_CONFIG_UDHCP_INSTALL_SIMPLE_SCRIPT),y)
	$(INSTALL_DIR) $(1)$(shell dirname $(CONFIG_BUSYBOX_CONFIG_UDHCPC_DEFAULT_SCRIPT))
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/examples/udhcp/simple.script $(1)$(CONFIG_BUSYBOX_CONFIG_UDHCPC_DEFAULT_SCRIPT)
 endif
	-rm -rf $(1)/lib64
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/bin
	$(CP) $(PKG_BUILD_DIR)/busybox-static $(1)/bin
endef

define Package/busybox-static/install
	$(INSTALL_DIR) $(1)/bin
	$(CP) $(PKG_BUILD_DIR)/busybox-static $(1)/bin
endef

$(eval $(call BuildPackage,busybox))
$(eval $(call BuildPackage,busybox-static))
