{ mylib, ... }:
{
  imports = mylib.scanPaths ./. true;
}
