# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# @name mise
# @brief Setup environment, and completions, for the mise tool manager.
# @repository https://github.com/johnstonskj/zsh-mise-plugin
# @homepage **include if different from repository URL**
# @version **use semantic versioning, e.g. 0.1.0, or remove**
# @license **use license expressions, e.g., MIT AND Apache-2.0, or remove**
# @copyright **copyright notice in lieu of license, e.g., ©️ YEAR FULL_NAME <EMAIL>, or remove**
#
# @description
#
# Long description TBD.
#

typeset -gi EC_SUCCESS
typeset -gi EC_NOT_INSTALLED_ERROR

typeset -g MISE_ENV

###################################################################################################
# @section Lifecycle
# @description Plugin lifecycle functions.
#

# Declare any dependencies here, it needs to be done BEFORE the plugin manager calls the plugin
# _init function. In this case, you now have access to logging functions.
@zplugins_declare_plugin_dependencies mise brew completion shlog

#
# @description
#
# Called when the plugin is loaded, allows for additional actions beyond those performed by
# the plugin manager.
#
# @noargs
#
mise_plugin_init() {
    builtin emulate -L zsh
    builtin setopt extended_glob warn_create_global typeset_silent no_short_loops rc_quotes no_auto_pushd

    MISE_ENV=${MISE_ENV:-}

    if homebrew_formula_exists mise; then
        @completion_generate_local_file_from mise completion zsh
        return ${EC_SUCCESS}
    else
        log_error "zsh-mise: the Homebrew formula 'mise' does not seem to be installed."
        return ${EC_NOT_INSTALLED_ERROR}
    fi
}
