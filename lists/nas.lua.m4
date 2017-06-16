include(utils.m4)dnl Include utility macros
dnl
-- Kernel --
Install "kmod-ata-ahci"
-- File systems
Install foreach(FS,`"kmod-fs-FS" ',afs,autofs4,btrfs,cifs,configfs,cramfs,exfat,exportfs,ext4,fscache,f2fs,hfs,hfsplus,isofs,jfs,minix,msdos,nfs,nfsd,ntfs,udf,vfat,xfs)
-- Native language support
Install foreach(NLS,`"kmod-nls-NLS" ',cp1250,cp1251,cp437,cp775,cp850,cp852,cp862,cp864,cp866,cp932,iso8859-1,iso8859-13,iso8859-15,iso8859-2,iso8859-6,iso8859-8,koi8r,utf8)
-- Raid
Install foreach(MD,`"kmod-md-MD" ',linear,multipath,raid0,raid1,raid10,raid456)
-- Additional kernel drivers
Install "kmod-usb-storage-extras" "kmod-usb2"
ifelse(_BOARD_,turris,Install "kmod-mmc-fsl-p2020" "kmod-fs-reiserfs" "reiserfsprogs")dnl
ifelse(_BOARD_,omnia,Install "kmod-ata-ahci-platform" "kmod-ata-mvebu-ahci" "kmod-crypto-marvell-cesa" "blkdiscard" "fstrim")

-- Tools --
Install "mount-utils" "losetup" "lsblk" "blkid" "file"
Install "fdisk" "cfdisk" "sfdisk" "hdparm" "resize2fs" "partx-utils"
Install "acl" "attr"
Install "mountd" "smartd" "smartmontools"
Install "swap-utils"

-- File systems
Install "lvm2" "mdadm" "mkdosfs" "mkhfs" "btrfs-progs" "davfs2" "e2fsprogs" "fuse-utils" "xfs-mkfs"
Install "block-mount" "badblocks" "cifsmount" "dosfsck" "hfsfsck" "xfs-fsck" "xfs-growfs"
Install "nfs-kernel-server" "nfs-kernel-server-utils"
Install "ntfs-3g" "ntfs-3g-utils"
Install "sshfs"

-- Network
Install "wget" "rsync" "rsyncd" "samba36-client" "samba36-server"

-- Luci
Install foreach(PKG,`"luci-app-PKG" ',hd-idle,minidlna,samba)
Install "luci-mod-admin-full"

_LUCI_I18N_
for lang in pairs(luci_i18n) do
	for _, pkg in pairs({"hd-idle", "minidlna", "samba"}) do
		Install("luci-i18n-" .. pkg .. "-" .. lang, { ignore = {"missing"} })
	end
end

-- Encryption --
Install "cryptsetup-openssl" "kmod-cryptodev" "kmod-crypto-user"
Install foreach(CRP,`"kmod-crypto-CRP" ',cbc,ctr,pcbc,des,ecb,xts)
Install foreach(CRP,`"kmod-crypto-CRP" ',cmac,crc32c,sha1,sha256,sha512,md4,md5,hmac)
Install foreach(CRP,`"kmod-crypto-CRP" ',seqiv,ccm,deflate)
