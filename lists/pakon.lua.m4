include(utils.m4)dnl Include utility macros
_FEATURE_GUARD_

Install("foris-pakon-plugin", "pakon", "pakon-lists", "suricata-pakon", { priority = 40 })
if for_l10n then
	for_l10n("foris-pakon-plugin-l10n-")
end

_END_FEATURE_GUARD_
