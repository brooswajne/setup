My setup, for easy migration to a new laptop.

## TODO

- Add scripts for automatically running as many of the setup steps as possible.

## Steps

1. Install applications:
   - [Firefox](https://www.mozilla.org/en-GB/firefox/developer/)
   - [iTerm2](https://iterm2.com/)
   - [1Password](https://1password.com/)
1. Setup vim
   ```bash
   ln -s vim ~/.vim
   ln vim/init.vim ~/.vimrc
   ```
1. Install [homebrew](https://brew.sh/)
1. Install [Fantasque Sans Mono](https://github.com/belluzj/fantasque-sans)
1. Use [iTerm2 theme](./iterm2)
1. Install [neovim](https://neovim.io/)
1. Setup neovim
   ```bash
   ln -s vim ~/.config/nvim
   ```
1. Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
   - Theme: [powerline10k](https://github.com/romkatv/powerlevel10k)
1. Link zsh config:
   ```bash
   ln .zshrc ~/.zshrc
   ln .zshrc.aliases ~/.zshrc.aliases
   ```
1. Install languages:
   - [nvm](https://github.com/nvm-sh/nvm) (node)
   - [deno](https://deno.land)
   - [rust](https://rust-lang.org)
1. Setup git
   - Prepend to `~/.gitconfig`:
     ```gitconfig
     [include]
       path = /path/to/setup/.gitconfig
     # ... any config for this laptop
     ```
   - Setup global hooks:
     ```bash
	 ln -s git-hooks ~/.githooks
	 ```

### Extras

- `bat` - https://github.com/sharkdp/bat
- `delta` - https://github.com/dandavison/delta
- Spotify - https://formulae.brew.sh/cask/spotify
- VSCode - https://formulae.brew.sh/cask/visual-studio-code
  - Extensions:
    - Better Comments - https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments
    - Comment tagged templates - https://marketplace.visualstudio.com/items?itemName=bierner.comment-tagged-templates
    - Deno - https://marketplace.visualstudio.com/items?itemName=denoland.vscode-deno
    - Error Lens - https://marketplace.visualstudio.com/items?itemName=usernamehw.errorlens
    - ESLint - https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint
    - GitLens - https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens
    - map-replace.js — https://marketplace.visualstudio.com/items?itemName=Yukai.map-replace-js
    - Markdown All in One - https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one
    - Partial Diff - https://marketplace.visualstudio.com/items?itemName=ryu1kn.partial-diff
    - Path Intellisense - https://marketplace.visualstudio.com/items?itemName=christian-kohler.path-intellisense
    - Prettify JSON - https://marketplace.visualstudio.com/items?itemName=mohsen1.prettify-json
    - Sort lines - https://marketplace.visualstudio.com/items?itemName=Tyriar.sort-lines
    - Svelte for VS Code - https://marketplace.visualstudio.com/items?itemName=svelte.svelte-vscode
