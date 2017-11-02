include(utils.m4)dnl Include utility macros
_FEATURE_GUARD_

-- Kernel --
Install("kmod-ata-ahci", { priority = 40 })
-- File systems
forInstall(kmod-fs,afs,autofs4,btrfs,cifs,configfs,cramfs,exfat,exportfs,ext4,fscache,f2fs,hfs,hfsplus,isofs,jfs,minix,msdos,nfs,nfsd,ntfs,udf,vfat,xfs)
-- Native language support
forInstall(kmod-nls,cp1250,cp1251,cp437,cp775,cp850,cp852,cp862,cp864,cp866,cp932,iso8859-1,iso8859-13,iso8859-15,iso8859-2,iso8859-6,iso8859-8,koi8r,utf8)
-- Raid
forInstall(kmod-md,linear,multipath,raid0,raid1,raid10,raid456)
-- Additional kernel drivers
Install("kmod-usb-storage-extras", "kmod-usb2", { priority = 40 })
if model:match("[Oo]mnia") then
	Install("kmod-ata-ahci-platform", "kmod-ata-mvebu-ahci", "kmod-crypto-marvell-cesa", "blkdiscard", "fstrim", "asm1062-fix", { priority = 40 })
elseif model:match("^[Tt]urris$") then
	Install("kmod-mmc-fsl-p2020", "kmod-fs-reiserfs", "reiserfsprogs", { priority = 40 })
end

-- Tools --
Install("mount-utils", "losetup", "lsblk", "blkid", "file", { priority = 40 })
Install("fdisk", "cfdisk", "hdparm", "resize2fs", "partx-utils", { priority = 40 })
Install("acl", "attr", { priority = 40 })
Install("mountd", "smartd", "smartmontools", { priority = 40 })
Install("swap-utils", { priority = 40 })

-- File systems
Install("lvm2", "mdadm", "mkdosfs", "mkhfs", "btrfs-progs", "davfs2", "e2fsprogs", "fuse-utils", "xfs-mkfs", { priority = 40 })
Install("block-mount", "badblocks", "cifsmount", "dosfsck", "hfsfsck", "xfs-fsck", "xfs-growfs", { priority = 40 })
Install("nfs-kernel-server", "nfs-kernel-server-utils", { priority = 40 })
Install("ntfs-3g", "ntfs-3g-utils", { priority = 40 })
Install("sshfs", { priority = 40 })

-- Network
Install("wget", "rsync", "rsyncd", "samba36-client", "samba36-server", { priority = 40 })

-- Luci
forInstall(luci-app,hd-idle,minidlna,samba)
Install("luci-mod-admin-full", { priority = 40 })

_LUCI_I18N_(hd-idle, minidlna, samba)

-- Encryption --
Install("cryptsetup-openssl", "kmod-cryptodev", "kmod-crypto-user", { priority = 40 })
forInstall(kmod-crypto,cbc,ctr,pcbc,des,ecb,xts)
forInstall(kmod-crypto,cmac,crc32c,sha1,sha256,sha512,md4,md5,hmac)
forInstall(kmod-crypto,seqiv,ccm,deflate)

_END_FEATURE_GUARD_
