#symlinks the dotfiles in this repo back to where they belong.
#I don't care about performance here.

if __name__ == "__main__":
    import os
    
    paths = [
        ".bashrc",
        ".dwm",
        ".config/nvim",
        ".config/neofetch",
        ".config/alacritty",
        ".emacs.d"
    ]
    
    cmd = ""
    
    for p in paths:
        cmd += f"ln -s ~/.dotfiles/{p} ~/{p} ; "
    
    os.system(cmd)

    #also provide Capital case links for home directories that programs automatically create but I don't want
    #os.system("mkdir ~/downloads ~/desktop")
    #os.system("ln -s ~/downloads ~/Downloads")
    #os.system("ln -s ~/desktop ~/Desktop")
    #os.system("ln -s ~/desktop ~/Images")
    #os.system("ln -s ~/desktop ~/Documents")
