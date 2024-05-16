{ ... }:
{
  programs.keychain = {
    enable = true;
    enableZshIntegration = true;
    keys = [ "id_rsa" ];
  };
}
