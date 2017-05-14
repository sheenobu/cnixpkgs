{ stdenv, go17Packages, callPackage }:
go17Packages.buildFromGitHub {
   rev = "1.7";
   owner = "cbednarski";
   repo = "hostess";
   sha256 = "";
   propagatedBuildInputs = [ ];
}
