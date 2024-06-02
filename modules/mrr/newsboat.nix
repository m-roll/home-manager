{ ... }:
{
  programs.newsboat = {
    enable = true;
    urls = [
      {
        url = "https://www.thesomervilletimes.com/feed";
        tags = [
          "news"
          "local"
          "somerville"
        ];
      }
    ];

    autoReload = true;
    browser = "brave"; # TODO: parameterize this
    reloadTime = 60;

    # TODO parameterize colors to i3 colors if possible
    extraConfig = ''
      color info green black
      color listfocus_unread green black bold
    '';
  };
}
