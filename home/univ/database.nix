{ config, pkgs, ... }:
{

  sops.secrets."univ/sql_pwd" = { };

  home.sessionVariables = {
    TNS_ADMIN = "${config.xdg.configHome}/oracle";
    TWO_TASK = "dbetu";
  };

  # programs.zsh.sessionVariables = {
  #   TNS_ADMIN = "${config.xdg.configHome}/oracle";
  # };

  xdg.configFile."oracle/tnsnames.ora".text = ''
    dbetu =
      (DESCRIPTION =
        (ADDRESS_LIST =
          (ADDRESS = (PROTOCOL = TCP)(HOST = inf-oracle.univ-rouen.fr)(PORT = 1521))
        )
        (CONNECT_DATA =
          (SID = dbetu)
        )
      )
  '';

  home.packages = with pkgs; [
    sqlcl
    oracle-instantclient

    (writeShellScriptBin "sqlplusfac" ''
      DB_PWD=$(cat ${config.sops.secrets."univ/sql_pwd".path})
      exec ${oracle-instantclient}/bin/sqlplus "M1INFO63/$DB_PWD"
    '')
    (writeShellScriptBin "sqlclfac" ''
      DB_PWD=$(cat ${config.sops.secrets."univ/sql_pwd".path})
      exec ${sqlcl}/bin/sqlcl "M1INFO63/$DB_PWD"
    '')
  ];
}

# 63
