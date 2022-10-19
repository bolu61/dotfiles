command?=cp $(flags)
flags?=-Rf

BASE?=$(HOME)
CONF?=$(or $(XDG_CONFIG_HOME),$(HOME)/.config)
DATA?=$(or $(XDG_DATA_HOME),$(HOME)/.local/share)




base=$(addprefix $(BASE)/,$(1))
conf=$(addprefix $(CONF)/,$(1))
data=$(addprefix $(DATA)/,$(1))


override define install
	$(if $(wildcard $(dir $@)),,mkdir -p $(dir $@))
	$(command)
endef

override define newline


endef


modname=$(addprefix !mod,$(1))
optname=$(addprefix !opt,$(1))


# define a module
mod=$(eval $(call modtemplate,$(call modname,$1),$2))$(call modname,$1)default: !bootstrap;$(newline)
override define modtemplate
.PHONY: $1 $1default
$1: $1default $2;
$(if $2,,,$2: $1default)
endef

# tag a dependency to a module
tag=$(eval $(call modname,$(2)): $(call modname,$(1))$(newline))

# opt
opt=$(eval $1: $(call modname,$1);)

# define submodules by directories
submodules=$(wildcard */.)

.PHONY: !default !bootstrap force
!default: $(call modname,common);
force:;
!bootstrap: $(!options) force;
# maybe for future use






$(call mod,common)
$(call opt,common)

$(call mod,ubuntu)
$(call opt,ubuntu)

platformcheck=$(if $(1),,$(error platform isn't defined))

$(call mod,hush,$(BASE)/.hushlogin)
$(call tag,hush,common)
$(BASE)/.hushlogin:
	touch $@


$(call mod,profile,$(BASE)/.profile)
$(BASE)/.profile: ./profile
	$(install) $< $@


$(call mod,git,$(CONF)/git/config)
$(CONF)/git/config: git/config
	$(install) $< $@


$(call mod,nvim,$(CONF)/nvim/init.lua $(CONF)/nvim/ftdetect)

$(CONF)/nvim/init.lua: nvim/init.lua | $(DATA)/nvim/site/pack/packer/start/packer.nvim
	$(install) $< $@
	nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' 2>/dev/null

$(DATA)/nvim/site/pack/packer/start/packer.nvim:
	-git clone --depth 1 https://github.com/wbthomason/packer.nvim \
	$(DATA)/nvim/site/pack/packer/start/packer.nvim

$(CONF)/nvim/ftdetect/%: nvim/ftdetect/%
	$(install) $< $@


# bash
$(call mod,bash,$(addprefix $(BASE)/.bash,_profile _login _logout rc))
$(call opt,bash)
$(call tag,profile,bash)

$(BASE)/.bash_%: bash/%
	$(install) $< $@

$(BASE)/.bashrc: bash/rc
	$(install) $< $@


$(call mod,pyenv, | $(DATA)/pyenv)
$(call opt,pyenv)
$(DATA)/pyenv:
	curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | PYENV_ROOT=$(DATA)/pyenv bash

