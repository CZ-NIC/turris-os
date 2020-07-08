include(utils.m4)dnl Include utility macros
_FEATURE_GUARD_

if model and installed then
	if not model:match("^[Tt]urris$") or installed["turris-btrfs"] then
		Install("tos3to4", { priority = 40 })
	else
		WARN("Migration for Turris 1.x on internal storage is not available. Please use microSD card (https://wiki.turris.cz/doc/cs/howto/btrfs_migration)")
	end
end

_END_FEATURE_GUARD_
