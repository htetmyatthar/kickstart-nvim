# My simple nvim config
Started using neovim from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) then added more and more following advice of Telescopic Jhonson.

# Guide to become a neovim god

Understand basics

- [Primeagne's series](https://www.youtube.com/watch?v=X6AR2RMB5tE&list=PLm323Lc7iSW_wuxqmKx_xxNtJC_hJbQ7R)

Understand deeply

- [Teej's manual ASMR](https://www.youtube.com/watch?v=rT-fbLFOCy0&t=2608s&pp=ygULdGVlaiBuZW92aW0%3D)

Teej's latest neovim teaching in 2024 Christmas

- [Advent of neovim](https://youtu.be/TQn2hJeHQbM?si=YQ9w_GDQG8wWDDmJ)

# After the you've cloned the repo

`bash
go install github.com/fatih/gomodifytags@latest # used for modifying json and other tags in golang
go install github.com/go-delve/delve/cmd/dlv@latest # for debuggin golang
sudo apt install xclip # for copying and pasting as one clipboard for the whole system.
sudo apt install python3-pip    # for installing packages
sudo apt install python3.*-venv # for python venv
pip3 install debugpy        # debugging python
sudo apt install ripgrep    # for telescope grepping with fzf
npm install -g neovim   # for node.js
npm install -g @olrtg/emmet-language-server
`


`bash
#for LuaSnip overriding the config and manual installation of jsregexp
cd ~/path/to/LuaSnip    
make install_jsregexp
`
