.PHONY: validate
PWD ?= $(shell 'pwd')
MAKE_DIR ?= make
MAKE_PATH := $(if $(CI),/usr/gnu/include/,$(shell echo $(PWD))/$(shell echo $(MAKE_DIR))/)

include $(MAKE_PATH)gmsl
include $(MAKE_PATH)*.mk

validate:
ifeq ($(call or,$(is_not_development_deployment),$(is_not_development_branch)),$(true))
	@make version/validate;
endif
	@make tf/validate \
		TF=$(TF) \
		TF_DIRECTORY=$(shell echo $(PWD)) \
		TF_BACKEND_CONFIG=false \
