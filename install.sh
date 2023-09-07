#!/bin/bash


sudo pacman -S --needed - < packagelist
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru

