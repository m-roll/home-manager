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

      unbind-key ENTER
      unbind-key j
      unbind-key J
      unbind-key k
      unbind-key K
      bind-key j down
      bind-key k up
      bind-key l open
      bind-key h quit

      macro m set browser "mpv %u"; open-in-browser ; set browser "w3m %u"
      macro l set browser "brave %u"; open-in-browser ; set browser "w3m %u"
    '';
  };
}
