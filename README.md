# brooswajne/setup

Batman's setup and dotfiles.

## TODO

- Add scripts for automatically running as many of the setup steps as possible.

## Steps

1. Install [homebrew](https://brew.sh/)

2. Install all brew packages:

   ```sh
   brew bundle
   ```

3. Setup vim config

   ```sh
   ln -s $(pwd)/vim ~/.config/nvim
   ln -s $(pwd)/vim ~/.vim
   ln -s $(pwd)/vim/init.vim ~/.vimrc
   ```

4. Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
   - Theme: [powerline10k](https://github.com/romkatv/powerlevel10k)

5. Link zsh config:

   ```sh
   ln -s $(pwd)/.zshrc ~/.zshrc
   ln -s $(pwd).zshrc.aliases ~/.zshrc.aliases
   ```

7. Setup git

   - Prepend to `~/.gitconfig`:

     ```gitconfig
     [include]
       path = /path/to/setup/.gitconfig
     # ... any config for this laptop
     ```

   - Setup global hooks:

     ```sh
     ln -s $(pwd)/git-hooks ~/.githooks
     ```
