{
  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    my-very-cool-background.url = "github:NKJe/nixscopy?dir=my-very-cool-background";
    sddm-sugar-candy.url = "github:NKJe/nixscopy?dir=sddm-sugar-candy";
    zsh-autocomplete.url = "github:NKJe/nixscopy?dir=zsh-autocomplete";
  };

  outputs = { self, nixpkgs, my-very-cool-background, sddm-sugar-candy, zsh-autocomplete, ... }:
    let
      inherit (builtins) map removeAttrs;

      inherit (nixpkgs.lib) flip foldl recursiveUpdate;

      packages = [
        my-very-cool-background 
        sddm-sugar-candy
        zsh-autocomplete
      ];
      onlyPackages = map (a: a.packages) packages;
      packagesCombined = foldl recursiveUpdate { } onlyPackages;
    in {
      packages = packagesCombined;
      hydraJobs = packagesCombined;
    };
}
