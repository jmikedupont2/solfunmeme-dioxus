#!/bin/bash
export PATH="/nix/var/nix/profiles/default/bin:$HOME/.nix-profile/bin:$PATH"
cd /mnt/data1/meta-introspector/submodules/solfunmeme-dioxus
exec nix develop --command dx serve --platform web --port 8108 --addr 0.0.0.0
