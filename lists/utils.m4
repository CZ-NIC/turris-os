divert(-1)

# We require the _BOARD_ variable to be defined so let's check
ifdef(`_BOARD_',,`errprint(`_BOARD_ have to be defied when gerating new userlist. For example pass argument -D _BOARD_=turris to m4.')m4exit(`1')')
# Also we need the _BRANCH_ variable, but if it isn't defined than it means deploy
# and if defined as deploy then we undefine it.
ifelse(_BRANCH_,deploy,`undefine(`_BRANCH_')',)


# Transform lines in file to comma separated arguments
# Usage: file2args(`FILE')
define(`file2args',`syscmd(test -f _INCLUDE_`'$1)ifelse(sysval,0,,`errprint(File $1 is missing!)m4exit(`1')')dnl
esyscmd(`sed "/^#/d;s/\s//g;/^\s*\$/d" '_INCLUDE_`$1 | paste -sd "," | tr -d "\n"')')

# Expand second argument for for all arguments after second one defined as macro
# with name of first argument.
# Usage: foreach(X,Text(X),a,b)
define(`foreach',`ifelse(eval($#>2),1,`pushdef(`$1',`$3')$2`'popdef(`$1')`'ifelse(eval($#>3),1,`$0(`$1',`$2',shift(shift(shift($@))))')')')

#
define(`_LUCI_I18N_',`local luci_i18n = {["en"] = true} -- we always install English localization
for _, lang in pairs(l10n or {}) do
	luci_i18n[lang] = true
end')

divert(0)dnl
