# nix_mac_os

- this repo tracks my use of [Nix](https://nixos.org/) on my Apple machines
- if it goes well, I'll invest more time in learning `Nix` and related technology

## v0

- goals
  - install the relevant tech and use it daily on one of my machines
  - modify amy configurations as I used the tech
  - in about one month assess my use and determine if I should continue with `Nix` on Apple machines
- tech
  - [Determinate Nix](https://determinate.systems/nix/)
  - [nix-darwin](https://github.com/nix-darwin/nix-darwin)
  - [Home Manager](https://nix-community.github.io/home-manager/)

### install Nix

#### Determinate Nix

- I used the [suggested installer](https://docs.determinate.systems/) from Determinate Systems
  - my inclination was to use [CLI installer](curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install), but `Determinate Systems` recommended their installer e.g. it will keep `Determine Nix` working even as the Appl OS is updated
  - I expect to use [FlakeHub](https://docs.determinate.systems/getting-started/individuals/) and other features in time
- I then made the [recommended changes](https://docs.determinate.systems/guides/nix-darwin/) to allow me to use `Determinate Nix` with `nix-darwin`
  - I made some changes e.g how I structured `darwinConfigurations` to avoid issues with the Apple OS

#### nix-darwin

- `nix-darwin` was set up via a [Flake](https://wiki.nixos.org/wiki/Flakes) by `Determinite`
- [nix-darwin Configuration Options](https://nix-darwin.github.io/nix-darwin/manual/index.html) was a good starting point, especially for some OS settings

#### Home Manager

- I opted to use `Home Manager` so that packages and, hopefully, other elements are set for a user
- while the `Home Manager` documentation provided some help, most of my settings were informed by internet search and reviewing GitHub repositories
