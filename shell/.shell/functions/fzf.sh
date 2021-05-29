# view/vim file
vf() { fzf --preview='head -$LINES {}' | xargs -r -I % $EDITOR %; }

# teleport
tp() { cd "$(ls -R ~| grep "./" | sed "s|.$||" | fzf )" && tree ; }

# install packages
pacs() { apt list | cut -d'/' -f1 | fzf -m | xargs sudo apt install -y ; }
