include(utils.m4)dnl Include utility macros
dnl
_FEATURE_GUARD_

Install("foris-tls-plugin")
if for_l10n then
	for_l10n("foris-tls-plugin-l10n-")
end

_END_FEATURE_GUARD_
