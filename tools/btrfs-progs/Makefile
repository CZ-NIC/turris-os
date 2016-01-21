#
# Copyright (C) 2009-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=btrfs-progs
PKG_VERSION:=4.3.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-v$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@KERNEL/linux/kernel/people/kdave/btrfs-progs/
PKG_MD5SUM:=ae04b324a059482e4c7e9710043c4e93
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/$(PKG_NAME)-v$(PKG_VERSION)

HOST_BUILD_PARALLEL:=1

HOST_FIXUP:=autoreconf

include $(INCLUDE_DIR)/host-build.mk

progs = btrfs btrfs-debug-tree btrfs-find-root btrfs-image btrfs-map-logical \
	btrfs-show-super btrfstune btrfs-zero-log fsck.btrfs mkfs.btrfs

HOST_CONFIGURE_ARGS += \
	--disable-backtrace \
	--disable-convert \
	--disable-documentation

$(eval $(call HostBuild))

