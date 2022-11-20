#!/bin/bash

set -o nounset # error when referencing undefined variables
set -o errexit # exit when command fails

# Format
git config --global format.pretty "%C(yellow)%h%Creset %s %C(red)(%an, %cr)%Creset"

# Filter
git config --global filter.lfs.clean "git-lfs clean %f"
git config --global filter.lfs.smudge "git-lfs smudge %f"
git config --global filter.lfs.required true

# Core
git config --global core.whitespace "fix,-indent-with-non-tab,trailing-space,cr-at-eol"
git config --global core.editor nvim
git config --global core.pager delta

# Interactive
git config --global interactive.diffFilter "delta --color-only"

# Delta
git config --global delta.features decorations
git config --global delta.navigate true
git config --global delta.line-numbers true

# Delta Decorations
git config --global delta.decorations.plus-style "syntax bold #012800"
git config --global delta.decorations.minus-style "syntax bold #340001"
git config --global delta.decorations.syntax-theme TwoDark

