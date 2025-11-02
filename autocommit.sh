#!/usr/bin/env bash
cd ~/nixos-config
git add .
git commit -m "$(date +%d.%m.%y) at $(date +%t)"
git branch -M main
git remote add origin https://github.com/Supply12/mrcoolcola-nix-dots.git
git push -u origin main
