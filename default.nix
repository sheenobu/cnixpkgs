{ pkgs ? (import <nixpkgs> {}) }:

let
  # let's define our own callPackage to avoid typing all dependencies
  callPackage = pkgs.lib.callPackageWith (pkgs // sheenobupkgs);

  goPkg = { t }: (pkgs.callPackage t {
      buildGoPackage = pkgs.buildGo17Package;
  }).bin // { outputs = [ "bin" ]; };

  sheenobupkgs = rec {
    discord = (pkgs.callPackage ./discord.nix) {};
    docker-compose = (pkgs.callPackage ./pkgs/docker-compose) {};
    gb = goPkg ./pkgs/gb;
    godot = (pkgs.callPackage ~/etc/godot.nix) {};
    gomobile = (pkgs.callPackage ./pkgs/gomobile) {};
    haxe = (pkgs.callPackage ./pkgs/haxe) { camlp4 = pkgs.ocamlPackages.camlp4; };
    # hostess = goPkg ./pkgs/hostess;
    osu = (pkgs.callPackage ./pkgs/osu) {};
    polybar = (pkgs.callPackage ./pkgs/polybar) {
      i3GapsSupport = true;
    };

    r8168 = (pkgs.callPackage ./pkgs/r8168/r8168.nix);
    riot = (pkgs.callPackage ./pkgs/riot) {};
    spotify = (pkgs.callPackage ~/etc/spotify.nix) {
      inherit (pkgs.gnome) GConf;
      libgcrypt = pkgs.libgcrypt_1_5;
      libpng = pkgs.libpng12;
    };
    vscode = (pkgs.callPackage ./pkgs/vscode) { }; # not in all-packages yet
    wingo = goPkg ./pkgs/wingo;
  };

in pkgs // {
  inherit sheenobupkgs;
}
