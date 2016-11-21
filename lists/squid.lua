if features and features.provides then
	Install "squid" "iptables-mod-tproxy" "ip6tables-mod-nat" { ignore = { 'missing' } }
end
