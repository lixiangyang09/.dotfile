function get_pwd() {
  echo "${PWD/$HOME/~}"
}


ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")$reset_color"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]"

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

DEFAULT_VENV_NAME=".venv"
alias create-venv2="virtualenv $DEFAULT_VENV_NAME"
alias create-venv="python3 -m venv $DEFAULT_VENV_NAME"
alias activate="source $DEFAULT_VENV_NAME/bin/activate"

function precmd() {
    if [[ -e ".venv" ]]; then
        # Check to see if already activated to avoid redundant activating
        if [[ "$VIRTUAL_ENV" != "$(pwd -P)/.venv" ]]; then
            echo "Activating python virtual environment"
            export VENV_ROOT=$PWD
           #create a python virtualenv environment without prompt prefix
            VIRTUAL_ENV_DISABLE_PROMPT=1
            source .venv/bin/activate
        fi
    else
        #"${PWD##/home/}" != "${PWD}" If $PWD starts with "/home/", it gets stripped off in the left side, which means it won't match the right side, so "!=" returns true.
        # The -n operator checks whether the string is not null.
        if [[ -n "$VENV_ROOT" ]]; then
            # out side of the .venv folder
            if [[ "${PWD##$VENV_ROOT}" = "$PWD" ]]; then
                echo "Deactivating python virtual environment"
                # should check if parent exists .venv
                type deactivate &> /dev/null && deactivate
                unset VENV_ROOT
                unset VIRTUAL_ENV_DISABLE_PROMPT
            else # inside the .venv folder
            fi
        fi
    fi
}
function python_venv() {
     if [[ -e ".venv" ]]; then
        echo "(venv)"
    else
        #"${PWD##/home/}" != "${PWD}" If $PWD starts with "/home/", it gets stripped off in the left side, which means it won't match the right side, so "!=" returns true.
        # The -n operator checks whether the string is not null.
        if [[ -n "$VENV_ROOT" ]]; then
            # out side of the .venv folder
            if [[ "${PWD##$VENV_ROOT}" = "$PWD" ]]; then
                # should check if parent exists .venv
            else # inside the .venv folder
                echo "(venv)"
            fi
        fi
    fi
}

export PROMPT="%{$fg[magenta]%}%n %{$fg[cyan]%}%m %{$fg[yellow]%}\$(get_pwd) \$(git_prompt_info) \$(python_venv)  %{$fg[blue]%}%D %*
%{$fg[green]%}%# %{$reset_color%}"


function pp() {
    if [[ "$1" == "" ]]
    then
        echo $PWD
    else
        if [[ "$1" == "/"* ]]
        then
       	    echo $1
        else
       	    echo $PWD"/"$1
        fi
    fi
}




function pftp() {
	if [ "$1" = "" ]
	then
	    echo "Usage: ftpp file_name"
	else
	    echo `whoami`"@"`hostname`:`pp $1`
	fi
}
