# nix_mac_os

This repo tracks my use of [Nix](https://nixos.org/) on my Apple machines.

## v0

I know very little about `Nix` and related technoogy; if this goes well, I'll invest more time in learning to use it with my Apple machines.

### goals

- install the relevant tech and use it as my primary package and system manager for at least one month
- tech
  - [Determinate Nix](https://determinate.systems/nix/)
  - [nix-darwin](https://github.com/nix-darwin/nix-darwin)
  - [Home Manager](https://nix-community.github.io/home-manager/)

#### install Nix

##### Determinate Nix

- I used the [suggested installer](https://docs.determinate.systems/) from Determinate Systems
  - my inclination was to use [CLI installer](curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install), but `Determinate Systems` recommended their installer e.g. it will keep `Determine Nix` working even as the Appl OS is updated
  - I expect to use [FlakeHub](https://docs.determinate.systems/getting-started/individuals/) and other features in time
- I then made the [recommended changes](https://docs.determinate.systems/guides/nix-darwin/) to allow me to use `Determinate Nix` with `nix-darwin`
  - I made some changes e.g how I structured `darwinConfigurations` to avoid issues with the Apple OS

##### nix-darwin

- `nix-darwin` was set up via a [Flake](https://wiki.nixos.org/wiki/Flakes) by `Determinite`
- [nix-darwin Configuration Options](https://nix-darwin.github.io/nix-darwin/manual/index.html) was a good starting point, especially for some OS settings

##### Home Manager

- I opted to use `Home Manager` so that packages and, hopefully, other elements are set for a user
- while the `Home Manager` documentation provided some help, most of my settings were informed by internet search and reviewing GitHub repositories
