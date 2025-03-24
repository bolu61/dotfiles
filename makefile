include preamble.mk


# disables login messages
$(call mod,hush): $(BASE)/.hushlogin;
$(call base,.hushlogin):;
	touch $@


# ghostty configuration
$(call mod,ghostty): $(call conf,ghostty/config)
$(call conf,ghostty/%): ghostty/%;
	$(install)


# neovim configuration
$(call mod,nvim): $(call conf,nvim/init.lua nvim/lua/mode.lua $(wildcard nvim/lua/plugins/*.lua));
$(call conf,nvim/%): nvim/%;
	$(install)


$(call mod,nvim-ftdetect): $(addprefix $(CONF)/,$(wildcard nvim/ftdetect/*));
$(call conf,nvim/ftdetect/%): nvim/ftdetect/%;
	$(install)


# zsh configuration
$(call mod,zsh): $(call data,zsh/.zprofile zsh/.zshrc);
$(call data,zsh/.zprofile): zsh/profile.zsh;
	$(install)
$(call data,zsh/.zshrc):;
	ZSH=$(call data,ohmyzsh) sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
