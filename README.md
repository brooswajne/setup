# brooswajne/setup

Batman's setup and dotfiles.

## TODO

- Add scripts for automatically running as many of the setup steps as possible.

## Steps

1. Install applications:
   - [Firefox](https://www.mozilla.org/en-GB/firefox/developer/)
   - [1Password](https://1password.com/)

2. Setup vim

   ```sh
   ln -s $(pwd)/vim ~/.vim
   ln -s $(pwd)/vim/init.vim ~/.vimrc
   ```

3. Install [homebrew](https://brew.sh/)

4. Install [kitty](https://sw.kovidgoyal.net/kitty/)

   ```sh
   brew install --cask kitty
   ln -s $(pwd)/kitty.conf ~/.config/kitty/kitty.conf
   ```

5. Install [Fantasque Sans Mono](https://github.com/belluzj/fantasque-sans)
   - [Patched NerdFont](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FantasqueSansMono) (install Mono of each variation)

6. Install [neovim](https://neovim.io/)

7. Setup neovim

   ```sh
   ln -s $(pwd)/vim ~/.config/nvim
   ```

8. Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
   - Theme: [powerline10k](https://github.com/romkatv/powerlevel10k)

9. Link zsh config:

   ```sh
   ln -s $(pwd)/.zshrc ~/.zshrc
   ln -s $(pwd).zshrc.aliases ~/.zshrc.aliases
   ```

10. Install languages:
    - [nvm](https://github.com/nvm-sh/nvm) (node)
    - [deno](https://deno.land)
    - [rust](https://rust-lang.org)

11. Setup git

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

### Extras

- `bat` - https://github.com/sharkdp/bat
- `delta` - https://github.com/dandavison/delta
- Spotify - https://formulae.brew.sh/cask/spotify
- VSCode - https://formulae.brew.sh/cask/visual-studio-code
