#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=busybox
PKG_VERSION:=1.29.3
PKG_RELEASE:=1
PKG_FLAGS:=essential

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://www.busybox.net/downloads \
		http://sources.buildroot.net
PKG_HASH:=0a367e19cdfd157e8258d87f893ee516

PKG_BUILD_DEPENDS:=BUSYBOX_USE_LIBRPC:librpc BUSYBOX_CONFIG_PAM:libpam
PKG_BUILD_PARALLEL:=1
PKG_CHECK_FORMAT_SECURITY:=0

#Busybox use it's own PIE config flag and LDFLAGS are used with ld, not gcc.
PKG_ASLR_PIE:=0

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE archival/libarchive/bz/LICENSE
PKG_CPE_ID:=cpe:/a:busybox:busybox

include $(INCLUDE_DIR)/package.mk

ifeq ($(DUMP),)
  STAMP_CONFIGURED:=$(strip $(STAMP_CONFIGURED))_$(shell grep '^CONFIG_BUSYBOX_' $(TOPDIR)/.config | mkhash md5)
endif

BUSYBOX_SYM=$(if $(CONFIG_BUSYBOX_CUSTOM),CONFIG,DEFAULT)
BUSYBOX_IF_ENABLED=$(if $(CONFIG_BUSYBOX_$(BUSYBOX_SYM)_$(1)),$(2))

define Package/busybox
  SECTION:=base
  CATEGORY:=Base system
  MAINTAINER:=Felix Fietkau <nbd@nbd.name>
  TITLE:=Core utilities for embedded Linux
  URL:=http://busybox.net/
  DEPENDS:=+BUSYBOX_USE_LIBRPC:librpc +BUSYBOX_CONFIG_PAM:libpam +BUSYBOX_CONFIG_NTPD:jsonfilter
  MENU:=1
  ALTERNATIVES:=\
    $(call BUSYBOX_IF_ENABLED,FLOCK,	100:/usr/bin/flock:/bin/busybox) \
    $(call BUSYBOX_IF_ENABLED,FREE,	100:/usr/bin/free:/bin/busybox) \
    $(call BUSYBOX_IF_ENABLED,IP,	100:/sbin/ip:/bin/busybox) \
    $(call BUSYBOX_IF_ENABLED,KILL,	100:/bin/kill:/bin/busybox) \
    $(call BUSYBOX_IF_ENABLED,PGREP,	100:/usr/bin/pgrep:/bin/busybox) \
    $(call BUSYBOX_IF_ENABLED,PKILL,	100:/usr/bin/pkill:/bin/busybox) \
    $(call BUSYBOX_IF_ENABLED,PMAP,	100:/usr/bin/pmap:/bin/busybox) \
    $(call BUSYBOX_IF_ENABLED,PS,	100:/bin/ps:/bin/busybox) \
    $(call BUSYBOX_IF_ENABLED,PWDX,	100:/usr/bin/pwdx:/bin/busybox) \
    $(call BUSYBOX_IF_ENABLED,TOP,	100:/usr/bin/top:/bin/busybox) \
    $(call BUSYBOX_IF_ENABLED,UPTIME,	100:/usr/bin/uptime:/bin/busybox) \
    $(call BUSYBOX_IF_ENABLED,WATCH,	100:/bin/watch:/bin/busybox) \

endef

define Package/busybox/description
 The Swiss Army Knife of embedded Linux.
 It slices, it dices, it makes Julian Fries.
endef

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

define Package/busybox/config
	source "$(SOURCE)/Config.in"
endef

# don't create a version string containing the actual timestamp
export KCONFIG_NOTIMESTAMP=1


ifndef CONFIG_USE_MUSL
LDLIBS:=m crypt
endif

LDLIBS += $(call BUSYBOX_IF_ENABLED,PAM,pam pam_misc pthread)
ifdef CONFIG_BUSYBOX_USE_LIBRPC
  LDLIBS += rpc
endif
ifeq ($(CONFIG_USE_GLIBC),y)
  LDLIBS += $(call BUSYBOX_IF_ENABLED,NSLOOKUP_OPENWRT,resolv)
endif

TARGET_CFLAGS += -flto
TARGET_LDFLAGS += -flto=jobserver -fuse-linker-plugin

MAKE_VARS :=
MAKE_FLAGS += \
	EXTRA_CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)" \
	EXTRA_LDFLAGS="$(TARGET_LDFLAGS)" \
	LDLIBS="$(LDLIBS)" \
	LD="$(TARGET_CC)" \
	SKIP_STRIP=y
ifneq ($(findstring c,$(OPENWRT_VERBOSE)),)
  MAKE_FLAGS += V=1
endif

define Build/Configure
	grep 'CONFIG_BUSYBOX_$(BUSYBOX_SYM)' $(TOPDIR)/.config | sed -e "s,\\(# \)\\?CONFIG_BUSYBOX_$(BUSYBOX_SYM)_\\(.*\\),\\1CONFIG_\\2,g" > $(PKG_BUILD_DIR)/.config
	yes 'n' | $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) oldconfig
	mv $(PKG_BUILD_DIR)/.config $(PKG_BUILD_DIR)/.config-regular
	cp ./files/busybox-static.config $(PKG_BUILD_DIR)/.config
	echo 'CONFIG_STATIC=y' >> $(PKG_BUILD_DIR)/.config
	yes 'n' | $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) oldconfig
	mv $(PKG_BUILD_DIR)/.config $(PKG_BUILD_DIR)/.config-static
	cp $(PKG_BUILD_DIR)/.config-regular $(PKG_BUILD_DIR)/.config
endef

define Build/Compile
	cp $(PKG_BUILD_DIR)/.config-static $(PKG_BUILD_DIR)/.config
	$(call Build/Compile/Default,all)
	cp $(PKG_BUILD_DIR)/busybox $(PKG_BUILD_DIR)/busybox-static
	$(call Build/Compile/Default,clean)
	cp $(PKG_BUILD_DIR)/.config-regular $(PKG_BUILD_DIR)/.config; touch $(PKG_BUILD_DIR)/.config
	$(call Build/Compile/Default,CONFIG_PREFIX="$(PKG_INSTALL_DIR)" all)
	rm -f $(PKG_BUILD_DIR)/busybox.links
	$(call Build/Compile/Default,CONFIG_PREFIX="$(PKG_INSTALL_DIR)" busybox.links)
	$(call Build/Compile/Default,CONFIG_PREFIX="$(PKG_INSTALL_DIR)" install)
endef

define Package/busybox/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
	$(INSTALL_DIR) $(1)/bin
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/sbin
	[ -z "`ls $(1)/usr/bin/ 2> /dev/null`" ] || for i in $(1)/usr/bin/*; do \
		[ "$$$$(basename $$$$i)" \!= env ] || continue; \
		echo Moving $$$$i && rm -f $$$$i &&  ln -s busybox $(1)/bin/`basename $$$$i`; \
	done
	[ -z "`ls $(1)/usr/sbin/ 2> /dev/null`" ] || for i in $(1)/usr/sbin/*; do \
		echo Moving $$$$i && rm -f $$$$i &&  ln -s ../bin/busybox $(1)/sbin/`basename $$$$i`; \
	done
	[ -e $(1)/usr/bin/env ] || ln -s ../../bin/busybox $(1)/usr/bin/env
	rm -f $(1)/sbin/ifup $(1)/sbin/ifdown
ifneq ($(CONFIG_BUSYBOX_$(BUSYBOX_SYM)_CROND),)
	$(INSTALL_BIN) ./files/cron $(1)/etc/init.d/cron
endif
ifneq ($(CONFIG_BUSYBOX_$(BUSYBOX_SYM)_NTPD),)
	$(INSTALL_BIN) ./files/sysntpd $(1)/etc/init.d/sysntpd
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) ./files/ntpd-hotplug $(1)/usr/sbin/ntpd-hotplug
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
