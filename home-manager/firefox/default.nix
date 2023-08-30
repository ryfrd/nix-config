{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    profiles.james = {
      isDefault = true;
      bookmarks = [
        {
          name = "nix package search";
          url = "https://search.nixos.org";
        }
      ];
      search = {
        force = true;
        default = "DuckDuckGo";
        order = [
          "DuckDuckGo"
        ];
      };
      settings = {
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.urlbar.maxRichResults" = 0;
        "browser.newtabpage.enabled" = true;
        "browser.startup.homepage" = "about:newtab";
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topStories" = false;
        "browser.newtabpage.activity-stream.topSitesRows" = 2;
        "browser.newtabpage.pinned" = [
          {
            name = "gunners";
            url = "https://reddit.com/r/gunners";
          }
          {
            name = "github";
            url = "https://github.com";
          }
          {
            name = "hacker news";
            url = "https://news.ycombinator.com";
          }
          {
            name = "nix packages";
            url = "https://search.nixos.org";
          }
          {
            name = "guardian";
            url = "https://theguardian.com";
          }
          {
            name = "lobsters";
            url = "https://lobste.rs";
          }
          {
            name = "twitch";
            url = "https://twitch.tv";
          }
          {
            name = "nts";
            url = "https://nts.live";
          }
          {
            name = "rym";
            url = "https://rateyourmusic.com";
          }
          {
            name = "gft";
            url = "https://glasgowfilm.org";
          }
          {
            name = "osm";
            url = "https://openstreetmap.org";
          }
          {
            name = "lichess";
            url = "https://lichess.org";
          }
          {
            name = "sport";
            url = "https://bbc.co.uk/sport";
          }
          {
            name = "hltv";
            url = "https://hltv.org";
          }
          {
            name = "ebay";
            url = "https://ebay.co.uk";
          }
          {
            name = "yt";
            url = "https://youtube.com";
          }
        ];
        "browser.uiCustomization.state" = /* json */ ''
        {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":[],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["firefox-view-button","tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar"],"currentVersion":19,"newElementCount":3}
        '';
      };
    };
  };
}
