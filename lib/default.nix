{ lib, ... }:

rec {
  scanPaths = path: recursive:
    let
      entries = builtins.readDir path;
    in
      builtins.concatLists (
        lib.attrsets.mapAttrsToList (name: type:
          let
            fullPath = path + "/${name}";
          in
            if type == "regular" && name != "default.nix" && lib.strings.hasSuffix ".nix" name then
              [ fullPath ]
            else if type == "directory" && recursive then
              scanPaths fullPath true
            else
              [ ]
        ) entries
      );
}
