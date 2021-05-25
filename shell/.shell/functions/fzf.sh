# view/vim file
vf() { fzf | xargs -r -I % $EDITOR %; }

# teleport
tp() { cd "$(ls -R ~| grep "./" | sed "s|.$||" | fzf )"; }
