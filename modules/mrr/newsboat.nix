{ ... }:
{
  programs.newsboat = {
    enable = true;
    urls = {
      "somerville-times" = {
        url = "https://www.thesomervilletimes.com/feed";
        tags = [
          "news"
          "local"
          "somerville"
        ];
      };
    };
    autoReload = true;
    browser = "brave"; # TODO: parameterize this
    reloadTime = 60;
  };
}
