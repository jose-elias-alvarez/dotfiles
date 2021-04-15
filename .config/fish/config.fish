set PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
set -x EDITOR nvim

set -x NNN_BMS 'd:~/Documents;n:~/Documents/Downloads;l:~/Local;g:~/git;c:~/.config;v:~/.config/nvim/lua'
set -x NNN_PLUG 'd:diffs;p:preview-tui;s:suedit;t:treeview;r:renamer'
set -x NNN_FIFO /tmp/nnn.fifo

set fish_greeting

functions --copy cd standard_cd
function cd
    standard_cd $argv; and exa --classify
end

function update_fasd_db --on-event fish_preexec
    fasd --proc (fasd --sanitize (eval echo $argv) | string split -n " ") &>/dev/null
end
