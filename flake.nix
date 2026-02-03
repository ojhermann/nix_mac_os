{
  description = "A flake template for nix-darwin and Determinate Nix";

  # Flake inputs
  inputs = {
    # Stable Nixpkgs (use 0.1 for unstable)
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    # Stable nix-darwin (use 0.1 for unstable)
    nix-darwin = {
      url = "https://flakehub.com/f/nix-darwin/nix-darwin/0.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Determinate 3.* module
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake outputs
  outputs =
    { self, ... }@inputs:
    let
      username = "otto";
      system = "aarch64-darwin";
    in
    {
      # nix-darwin configuration output
      darwinConfigurations = {
        "ottos-MacBook-Air" = inputs.nix-darwin.lib.darwinSystem {
          system = "${system}";
          modules = [
            inputs.determinate.darwinModules.default
            self.darwinModules.base
            self.darwinModules.determinateNixConfig
            inputs.home-manager.darwinModules.home-manager
            (
              { ... }:
              {
                # https://docs.determinate.systems/guides/nix-darwin/
                nix.enable = false;
                # home-manager
                home-manager.users.${username} =
                  { ... }:
                  {
                    home.username = "${username}";
                    home.stateVersion = "25.11";
                    imports = [ ./home.nix ];
                  };
                # security
                security.pam.services.sudo_local.touchIdAuth = true;
                # system
                system.primaryUser = username;
                system.defaults = {
                  dock = {
                    autohide = true;
                    mru-spaces = false;
                  };
                  finder = {
                    AppleShowAllExtensions = true;
                  };
                  iCal."first day of week" = "Monday";
                  loginwindow = {
                    LoginwindowText = "By entering, you agree that Shakes the Clown is the best film ever made";
                  };
                  menuExtraClock = {
                    Show24Hour = true;
                    ShowSeconds = true;
                  };
                  NSGlobalDomain = {
                    AppleICUForce24HourTime = true;
                    AppleInterfaceStyle = "Dark";
                    AppleMeasurementUnits = "Centimeters";
                    AppleMetricUnits = 1;
                    AppleShowAllFiles = true;
                    AppleTemperatureUnit = "Celsius";
                    NSAutomaticCapitalizationEnabled = false;
                  };
                };
              }
            )
          ];
        };
      };

      # nix-darwin module outputs
      darwinModules = {
        # Some base configuration
        base =
          { ... }:
          {
            # Required for nix-darwin to work
            system.stateVersion = 1;

            users.users.${username} = {
              name = username;
              home = "/Users/${username}";
              # See the reference docs for more on user config:
              # https://nix-darwin.github.io/nix-darwin/manual/#opt-users.users
            };

            # Other configuration parameters
            # See here: https://nix-darwin.github.io/nix-darwin/manual
          };

        # Determinate Nix configuration
        determinateNixConfig =
          {
            config,
            pkgs,
            lib,
            ...
          }:
          {
            determinateNix = {
              # Enable Determinate to handle your Nix configuration
              enable = true;

              # Custom Determinate Nix settings written to /etc/nix/nix.custom.conf
              customSettings = {
                # Enables parallel evaluation (remove this setting or set the value to 1 to disable)
                eval-cores = 0;
                extra-experimental-features = [
                  "build-time-fetch-tree" # Enables build-time flake inputs
                ];
                # Other settings
              };
            };
          };

        # Add other module outputs here
      };

      # Development environment
      devShells.${system}.default =
        let
          pkgs = import inputs.nixpkgs { inherit system; };
        in
        pkgs.mkShellNoCC {
          packages = with pkgs; [
            # Shell script for applying the nix-darwin configuration.
            # Run this to apply the configuration in this flake to your macOS system.
            (writeShellApplication {
              name = "apply-nix-darwin-configuration";
              runtimeInputs = [
                # Make the darwin-rebuild package available in the script
                inputs.nix-darwin.packages.${system}.darwin-rebuild
              ];
              text = ''
                echo "> Applying nix-darwin configuration..."

                echo "> Running darwin-rebuild switch as root..."
                sudo darwin-rebuild switch --flake .
                echo "> darwin-rebuild switch was successful ✅"

                echo "> macOS config was successfully applied 🚀"
              '';
            })

            self.formatter.${system}
          ];
        };

      # Nix formatter

      # This applies the formatter that follows RFC 166, which defines a standard format:
      # https://github.com/NixOS/rfcs/pull/166

      # To format all Nix files:
      # git ls-files -z '*.nix' | xargs -0 -r nix fmt
      # To check formatting:
      # git ls-files -z '*.nix' | xargs -0 -r nix develop --command nixfmt --check
      formatter.${system} = inputs.nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
    };
}
