#symlinks the dotfiles in this repo back to where they belong.
#I don't care about performance here.

if __name__ != "__main__":
    return

import os

#format is relative_here:absolute_there
paths = {
    "bashrc" : "~/.bashrc"
}
dir_path = os.path.dirname(os.path.realpath(__file__))

for k, v in paths.items():
    os.system(f"ln -s {dir_path}/{k} {v}")

#also provide Capital case links for home directories that programs tend to want but I do not
os.system("mkdir ~/downloads ~/desktop")
os.system("ln -s ~/downloads ~/Downloads")
os.system("ln -s ~/desktop ~/Desktop")
os.system("ln -s ~/desktop ~/Images")
os.system("ln -s ~/desktop ~/Documents")
