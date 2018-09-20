# Use the default kernel version if the Makefile doesn't override it

LINUX_RELEASE?=1

LINUX_VERSION-3.18 = .63
LINUX_VERSION-4.1 = .6
LINUX_VERSION-4.4 = .157

LINUX_KERNEL_MD5SUM-3.18 = f160ddc843a9c27c2a1b668693604f8f
LINUX_KERNEL_MD5SUM-4.1.6 = 1dae0c808e34164cab3dfd57be88bd53
LINUX_KERNEL_MD5SUM-4.4 = f43d0326a423ef0935f15886023144be

ifdef KERNEL_PATCHVER
  LINUX_VERSION:=$(KERNEL_PATCHVER)$(strip $(LINUX_VERSION-$(KERNEL_PATCHVER)))
endif

split_version=$(subst ., ,$(1))
merge_version=$(subst $(space),.,$(1))
KERNEL_BASE=$(firstword $(subst -, ,$(LINUX_VERSION)))
KERNEL=$(call merge_version,$(wordlist 1,2,$(call split_version,$(KERNEL_BASE))))
KERNEL_PATCHVER ?= $(KERNEL)

# disable the md5sum check for unknown kernel versions
LINUX_KERNEL_MD5SUM:=$(LINUX_KERNEL_MD5SUM-$(strip $(LINUX_VERSION)))
LINUX_KERNEL_MD5SUM?=x
