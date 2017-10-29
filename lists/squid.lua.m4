include(utils.m4)dnl Include utility macros
_FEATURE_GUARD_

Install("squid", { priority = 40 })
Install("iptables-mod-tproxy", "ip6tables-mod-nat", { priority = 40 })

_END_FEATURE_GUARD_
