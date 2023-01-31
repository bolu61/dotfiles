command?=cp
flags?=-Rf

BASE?=$(HOME)
CONF?=$(or $(XDG_CONFIG_HOME),$(HOME)/.config)
DATA?=$(or $(XDG_DATA_HOME),$(HOME)/.local/share)



base=$(addprefix $(BASE)/,$(1))
conf=$(addprefix $(CONF)/,$(1))
data=$(addprefix $(DATA)/,$(1))


override define install
	$(if $(wildcard $(dir $@)),,mkdir -p $(dir $@))
	$(command) $(flags)
endef

empty:=
space:=$(empty) $(empty)
override define newline


endef

join=$(subst $(space),$1,$(strip $2))


modname=$(addprefix !mod,$(1),$(if $2,-$2))
optname=$(addprefix !opt,$(1))


recipe=$(eval .PHONY: $1)$1

# define a module
mod=$(call recipe,$(call modname,$1))
# opt
opt=$(if $(filter $2,$(modules)),$(eval $(call modname,$1):$(call modname,$1,$2)))$(call recipe,$(call modname,$1,$2))


.PHONY: install .force
.force:;
# maybe for future use


$(foreach mod,$(modules),$(eval $(call optname,$(mod)):=$(newline)))

install: $(foreach mod,$(modules),$(call modname,$(mod)));


subdirectories:=$(subst /.,,$(wildcard */.))
$(foreach directory,$(subdirectories),$(eval $(directory):;$(MAKE) -C $(directory)))


$(call mod,common): $(foreach module,hush nvim profile,$(call mod,module))


$(call mod,ubuntu):


$(call mod,hush): $(BASE)/.hushlogin;
$(BASE)/.hushlogin:
	touch $@


$(call mod,profile): $(BASE)/.profile;
$(BASE)/.profile: profile/profile.sh
	$(eval content:=$(file < $<:{{DOTFILESMODULES}}=hi))
	$(warning $(content))
	$(install) $< $@


$(call mod,git): $(CONF)/git/config;
$(CONF)/git/config: git/config
	$(install) $< $@

$(call mod,nvim): $(CONF)/nvim/init.lua $(CONF)/nvim/lua/keymaps.lua $(addprefix $(CONF)/,$(wildcard nvim/lua/plugins/*.lua));

$(CONF)/nvim/init.lua: nvim/init.lua
	$(install) $< $@

$(CONF)/nvim/lua/keymaps.lua: nvim/lua/keymaps.lua
	$(install) $< $@

$(CONF)/nvim/lua/plugins/%: nvim/lua/plugins/%
	$(install) $< $@

$(call mod,ftdetect): $(addprefix $(CONF)/,$(wildcard nvim/ftdetect/*));
$(CONF)/nvim/ftdetect/%: nvim/ftdetect/%
	$(install) $< $@


# bash
$(call mod,bash): $(call modname,profile) $(addprefix $(BASE)/.bash,_profile _login _logout rc);
$(BASE)/.bash_%: bash/%;
	$(install) $< $@
$(BASE)/.bashrc: bash/rc;
	$(install) $< $@


# pyenv
$(call mod,pyenv): $(DATA)/pyenv;
$(DATA)/pyenv:
	curl https://pyenv.run | bash

$(call opt,pyenv,bash): $(call opt,pyenv,profile)
$(call opt,pyenv,profile): $(DATA)/profile/70-pyenv.sh
$(DATA)/profile/%-pyenv.sh: pyenv/profile.sh | $(call mod,profile);
	$(install) $< $@

