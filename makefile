include preamble.mk


$(call mod,hush): $(BASE)/.hushlogin;
# disables login messages

$(BASE)/.hushlogin:
	touch $@


$(call mod,profile): $(BASE)/.profile;
# user profiles, including env variables and configurations

$(BASE)/.profile: profile/profile.sh
	$(eval content:=$(file < $<:{{DOTFILESMODULES}}=$(modules)))
	$(warning $(content))
	$(install) $< $@


$(call mod,alacritty): $(call conf,alacritty/alacritty.yml alacritty/catppuccin/catppuccin-frappe.yml alacritty/catppuccin/catppuccin-macchiato.yml alacritty/catppuccin/catppuccin-mocha.yml, alacritty/catppuccin/catppuccin-latte.yml)
# alacritty configuration

$(call conf,alacritty/%): alacritty/%
	$(install) $< $@


$(call mod,nvim): $(CONF)/nvim/init.lua $(CONF)/nvim/lua/keymaps.lua $(CONF)/nvim/lua/mode.lua $(addprefix $(CONF)/,$(wildcard nvim/lua/plugins/*.lua));
# neovim configuration

$(CONF)/nvim/init.lua: nvim/init.lua
	$(install) $< $@

$(CONF)/nvim/lua/keymaps.lua: nvim/lua/keymaps.lua
	$(install) $< $@

$(CONF)/nvim/lua/mode.lua: nvim/lua/mode.lua
	$(install) $< $@

$(CONF)/nvim/lua/plugins/%: nvim/lua/plugins/%
	$(install) $< $@

$(call mod,ftdetect): $(addprefix $(CONF)/,$(wildcard nvim/ftdetect/*));
$(CONF)/nvim/ftdetect/%: nvim/ftdetect/%
	$(install) $< $@


$(call mod,bash): $(addprefix $(BASE)/.bash,_profile _login _logout rc);
# bash configuration

$(BASE)/.bash_%: bash/%;
	$(install) $< $@

$(BASE)/.bashrc: bash/rc;
	$(install) $< $@


$(call mod,pyenv): $(DATA)/pyenv;
# pyenv installation

$(DATA)/pyenv:
	git clone https://github.com/pyenv/pyenv.git $@

$(call opt,pyenv,profile): $(DATA)/profile/70-pyenv.sh
$(DATA)/profile/%-pyenv.sh: pyenv/profile.sh | $(call mod,profile);
	$(install) $< $@
