command?=cp $(flags)
flags?=-Rf

BASE?=$(HOME)
CONF?=$(or $(XDG_CONFIG_HOME),$(HOME)/.config)
DATA?=$(or $(XDG_DATA_HOME),$(HOME)/.local/share)

override define install
	@mkdir -p $(dir $@)
	$(command)
endef


# profile
common: $(BASE)/.profile
$(BASE)/.profile: profile
	$(install) $< $@

# hush
common: $(BASE)/.hushlogin
$(BASE)/.hushlogin:
	touch $@

# git
common: $(CONF)/git/config
$(CONF)/git/config: config/git/config
	$(install) $< $@

# nvim
common: nvim
nvim: $(CONF)/nvim/init.lua
	-nvim --headless +PackerSync +qa
$(CONF)/nvim/init.lua: config/nvim/init.lua
	$(install) $< $@

# bash
bash: $(addprefix $(BASE)/.bash,_profile _logout rc)
$(BASE)/.bash_%: bash%
	$(install) $< $@
$(BASE)/.bashrc: bashrc
	$(install) $< $@
