#
## Copyright (C) 2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#


#GO_SRC_DIR must be set from package
#example from obfs4proxy
#GO_SRC_DIR:=$(PKG_BUILD_DIR)/obfs4proxy/


OBFS_DIR:=$(GO_SRC_DIR)
GO_CMD:=$(STAGING_DIR_HOST)/go/bin/go

define Build/Compile/Go
	(export GOROOT=$(STAGING_DIR_HOST)/go ; \
	export GOTOOLDIR=$(STAGING_DIR_HOST)/go/pkg/tool/linux_amd64 ; \
	export GOPATH=$(OBFS_DIR) ; \
	export GOARCH=arm ; \
	export GOARM=7 ; \
	export GOBIN=$(OBFS_DIR)bin/  ; \
	export -p ; \
	cd $(OBFS_DIR) ; \
	$(GO_CMD) env ; \
	$(GO_CMD) get -d . ; \
	$(GO_CMD) build . ; \
	)
endef

