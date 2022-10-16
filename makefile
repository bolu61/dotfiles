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
$(CONF)/git/config: git/config
	$(install) $< $@

# nvim
common: nvim
nvim: $(CONF)/nvim/init.lua
$(CONF)/nvim/init.lua: nvim/init.lua $(DATA)/nvim/site/pack/packer/start/packer.nvim
	$(install) $< $@
	nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' 2>/dev/null
$(DATA)/nvim/site/pack/packer/start/packer.nvim:
	-git clone --depth 1 https://github.com/wbthomason/packer.nvim \
	$(DATA)/nvim/site/pack/packer/start/packer.nvim


# bash
bash: $(addprefix $(BASE)/.bash,_profile _login _logout rc)
$(BASE)/.bash_%: bash/%
	$(install) $< $@
$(BASE)/.bashrc: bash/rc
	$(install) $< $@
