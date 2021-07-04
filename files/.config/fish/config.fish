set fish_greeting

# Fish syntax highlighting
set -g fish_color_autosuggestion 555 brblack
set -g fish_color_cancel -r
set -g fish_color_command --bold
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end brmagenta
set -g fish_color_error brred
set -g fish_color_escape bryellow --bold
set -g fish_color_history_current --bold
set -g fish_color_host normal
set -g fish_color_match --background=brblue
set -g fish_color_normal normal
set -g fish_color_operator bryellow
set -g fish_color_param cyan
set -g fish_color_quote yellow
set -g fish_color_redirection brblue
set -g fish_color_search_match bryellow '--background=brblack'
set -g fish_color_selection white --bold '--background=brblack'
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline

# Hydro
set -g hydro_color_pwd green
set -g hydro_color_git brblack
set -g hydro_color_error red
set -g hydro_color_prompt magenta
set -g hydro_color_duration yellow

# code 
set fish_user_paths "/mnt/c/Users/joaob/AppData/Local/Programs/Microsoft VS Code Insiders/bin" $fish_user_paths

# docker
set fish_user_paths "/mnt/c/Program Files/Docker/Docker/resources/bin" $fish_user_paths
set fish_user_paths /mnt/c/ProgramData/DockerDesktop/version-bin $fish_user_paths

# GWSL
set --export WSL2 1
set ipconfig_exec (wslpath "C:\\Windows\\System32\\ipconfig.exe")
if which ipconfig.exe >/dev/null
    set ipconfig_exec (which ipconfig.exe)
end

set wsl2_d_tmp (eval $ipconfig_exec | grep -n -m 1 "Default Gateway.*: [0-9a-z]" | cut -d : -f 1)
if test -n "$wsl2_d_tmp"
    set first_line (expr $wsl2_d_tmp - 4)
    set wsl2_d_tmp (eval $ipconfig_exec | sed $first_line,$wsl2_d_tmp!d | grep IPv4 | cut -d : -f 2 | sed -e "s|\s||g" -e "s|\r||g")
    set --export DISPLAY "$wsl2_d_tmp:0"
    set -e first_line
else
    set --export DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
end

set -e wsl2_d_tmp
set -e ipconfig_exec

# if not type -q node
#     nvm install lts >/dev/null
# end

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true


# Aliases
alias code="_execute_if_available code-insiders"
alias expose="_execute_if_available npx localtunnel"
alias serve="_execute_if_available npx http-server"
alias yalc="_execute_if_available npx yalc"
alias dc="_execute_if_available docker compose"
alias dka="_execute_if_available docker kill (docker ps -q)"
