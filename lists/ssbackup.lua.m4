include(utils.m4)dnl Include utility macros
_FEATURE_GUARD_

Install("foris-ssbackups-plugin", { priority = 40 })
if for_l10n then
	for_l10n("foris-ssbackups-plugin-l10n-")
end

_END_FEATURE_GUARD_
