include preamble.mk


# disables login messages
$(call mod,hush): $(BASE)/.hushlogin;
$(call base,.hushlogin):;
	touch $@


# user profiles, including env variables and configurations
$(call mod,profile): $(BASE)/.profile;
$(call base,.profile): profile/profile.sh;
	$(install) $< $@


# alacritty configuration
$(call mod,alacritty): $(call conf,alacritty/alacritty.yml alacritty/catppuccin/catppuccin-frappe.yml alacritty/catppuccin/catppuccin-macchiato.yml alacritty/catppuccin/catppuccin-mocha.yml, alacritty/catppuccin/catppuccin-latte.yml)
$(call conf,alacritty/%): alacritty/%;
	$(install) $< $@


# neovim configuration
$(call mod,nvim): $(CONF)/nvim/init.lua $(CONF)/nvim/lua/keymaps.lua $(CONF)/nvim/lua/mode.lua $(addprefix $(CONF)/,$(wildcard nvim/lua/plugins/*.lua));
$(call conf,nvim/%): nvim/%;
	$(install) $< $@


$(call mod,nvim-ftdetect): $(addprefix $(CONF)/,$(wildcard nvim/ftdetect/*));
$(call conf,nvim/ftdetect/%): nvim/ftdetect/%;
	$(install) $< $@


# bash configuration
$(call mod,bash): $(addprefix $(BASE)/.bash,_profile _login _logout rc);
$(call conf,.bash_%): bash/%;
	$(install) $< $@
$(call conf,.bashrc): bash/rc;
	$(install) $< $@


# pyenv installation
$(call mod,pyenv): $(DATA)/pyenv;
$(call data,pyenv):
	git clone https://github.com/pyenv/pyenv.git $@

$(call opt,pyenv,profile): $(DATA)/profile/70-pyenv.sh;
$(call data,%-pyenv.sh): pyenv/profile.sh;
	$(install) $< $@
