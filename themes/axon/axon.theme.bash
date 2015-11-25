#!/usr/bin/env bash

function get_hour_color {
    hour_color=$red
    min=$(date +%M)
    if [ "$min" -lt "15" ]; then
        hour_color=$white
    elif [ "$min" -lt "30" ]; then
        hour_color=$green
    elif [ "$min" -lt "45" ]; then
        hour_color=$yellow
    else
        hour_color=$red
    fi
    echo "$hour_color"
}


PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
PS1="[\u@\h \W]\\$ "

PS1="$(get_hour_color)$(date +%H) ${bold_red}\h${reset_color} ${prompt_color}\W \\$\[\e[0;37m\] "

# Turn on parallel history
shopt -s histappend
history -a
# Turn on checkwinsize
shopt -s checkwinsize
[ "$PS1" = "\\s-\\v\\\$ " ] && PS1="[\u@\h \W]\\$ "
pathmunge () {
	case ":${PATH}:" in
		   *:"$1":*)
			   ;;
		   *)
			   if [ "$2" = "after" ] ; then
				   PATH=$PATH:$1
			   else
				   PATH=$1:$PATH
               fi
    esac
}

unset -f pathmunge
