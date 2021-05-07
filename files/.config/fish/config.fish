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
fish_add_path "/mnt/c/Users/joaob/AppData/Local/Programs/Microsoft VS Code Insiders/bin"

# docker
fish_add_path "/mnt/c/Program Files/Docker/Docker/resources/bin"
fish_add_path /mnt/c/ProgramData/DockerDesktop/version-bin

# skaffold
fish_add_path /mnt/c/Users/joaob/scoop/apps/skaffold/current

# brew
fish_add_path /home/linuxbrew/.linuxbrew/bin
fish_add_path /home/linuxbrew/.linuxbrew/sbin

if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

# deno dvm
fish_add_path /home/m4rc3l05/.deno/bin

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
