{ mylib, ... }:

{
  imports = mylib.scanPaths ./. false;
}
