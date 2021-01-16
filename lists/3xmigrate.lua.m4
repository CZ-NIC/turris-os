include(utils.m4)dnl Include utility macros
_FEATURE_GUARD_

if model and installed then
	if not model:match("^[Tt]urris$") then
		Install("tos3to4", { priority = 40 })
		Package("tos3to4", { replan = "finished" })
	else
		--WARN("Migration for Turris 1.x on internal storage is not available. Please use microSD card (https://wiki.turris.cz/doc/cs/howto/btrfs_migration)")
		WARN("Migration for Turris 1.x is not available at the moment.")
	end
end

_END_FEATURE_GUARD_
