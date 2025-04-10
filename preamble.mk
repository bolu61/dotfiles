command?=ln -sf "$(realpath $<)" "$@"


# xdg base directories

space:=$(subst ,, )
escape=$(subst $(space),\ ,$(1))

BASE?=$(call escape,$(HOME))
CONF?=$(or $(call escape,$(XDG_CONFIG_HOME)),$(HOME)/.config)
DATA?=$(or $(call escape,$(XDG_DATA_HOME)),$(HOME)/.local/share)


# xdg base directories convenience macros

base=$(addprefix $(BASE)/,$(1))
conf=$(addprefix $(CONF)/,$(1))
data=$(addprefix $(DATA)/,$(1))


# install recipe

override define install
	$(if $(wildcard $(dir $@)),,mkdir -p $(dir $@))
	$(command)
endef


# recipe macro

recipe=$(eval .PHONY: $1)$1


# module definition macro

modname=$(1)$(if $2,+$2)
mod=$(call recipe,$(call modname,$1))
opt=$(if $(filter $2,$(MAKECMDGOALS)),$(eval $(call modname,$1):$(call modname,$1,$2)))$(call recipe,$(call modname,$1,$2))
