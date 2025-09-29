{ root, lib, pkgs, inputs, ... }:

{
  home = {
    packages = with pkgs; [
      handlr
    ];

    sessionVariables = {
      MOZ_USE_XINPUT2 = 1;
    };
  };

  programs.librewolf = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;

        bookmarks = {
          force = true;

          settings = [
            {
              name = "Toolbar";
              toolbar = true;

              bookmarks =
                let
                  entry = name: url: { inherit name url; };
                  folder = name: bookmarks: { inherit name bookmarks; };
                in
                [
                  (entry "YouTube Music" "https://music.youtube.com")
                  "separator"
                  (entry "Discord" "https://discord.com/channels/@me")
                  (entry "Instagram" "https://instagram.com/")
                  "separator"
                  (entry "Anime-Sama" "https://anime-sama.fr/")
                  (entry "YouTube" "https://youtube.com/")
                  (entry "GitHub" "https://github.com/")
                  (entry "Proton Mail" "https://account.proton.me/mail")
                  "separator"
                  (entry "ENT" "https://ent.univ-lille.fr/")
                  (entry "Portail" "https://www.fil.univ-lille.fr/portail/index.php?dipl=L&sem=S5")
                  (entry "Moodle" "https://moodle.univ-lille.fr")
                  (entry "GitLab" "https://gitlab-etu.fil.univ-lille.fr/")
                  (entry "Zimbra" "https://zimbra.univ-lille.fr")
                  "separator"
                  (folder "Nix" [
                    (entry "Nixpkgs" "https://search.nixos.org/packages")
                    (entry "NixOS options" "https://search.nixos.org/options")
                    (entry "Home-Manager options" "https://home-manager-options.extranix.com/")
                    (entry "Noogle" "https://noogle.dev/")
                  ])
                ];
            }
          ];
        };

        containersForce = true;
        containers = {
          "default" = {
            id = 0;
            name = "Default";
            color = "pink";
          };

          "yt-music" = {
            id = 1;
            name = "YouTube Music";
            color = "red";
          };
        };

        userChrome = (builtins.readFile "${inputs.firefox-onebar}/onebar.css") + ''
          #navigator-toolbox {
            border-bottom: none !important;
          }

          #nav-bar {
            border-top: none !important;
          }
        '';

        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          darkreader
          istilldontcareaboutcookies
          multi-account-containers
          tabliss
          ublock-origin

          (buildFirefoxXpiAddon rec {
            pname = "kureteiyu-dark-theme";
            version = "1.0";
            addonId = "{f00ce5dc-ec40-41d1-abb5-8a974e97dae4}";
            url = "https://addons.mozilla.org/firefox/downloads/file/4387100/kureteiyu_dark_theme-${version}.xpi";
            sha256 = "452087ffa7db1fe753770d074e94d0220fd9278aa626b1c69ff53f25a4a7ac7b";
            meta = {};
          })
        ];

        settings = {
          "privacy.resistFingerprinting" = false;
          "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;

          "extensions.autoDisableScopes" = 0;

          "xpinstall.signatures.required" = false;

          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.tabs.inTitlebar" = 0;

          "browser.translations.automaticallyPopup" = false;
          "browser.aboutConfig.showWarning" = false;

          "extensions.activeThemeID" = "{f00ce5dc-ec40-41d1-abb5-8a974e97dae4}";

          "browser.toolbars.bookmarks.visibility" = "newtab";

          "browser.uiCustomization.state" = ''
            {
              "placements": {
                "nav-bar": [
                  "home-button",
                  "back-button",
                  "forward-button",
                  "stop-reload-button",
                  "urlbar-container",
                  "downloads-button",
                  "unified-extensions-button",
                  "ublock0_raymondhill_net-browser-action",
                  "addon_darkreader_org-browser-action",
                  "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
                ],
                "toolbar-menubar": [
                  "menubar-items"
                ],
                "TabsToolbar": [
                  "tabbrowser-tabs",
                  "new-tab-button",
                  "alltabs-button"
                ],
                "PersonalToolbar": [
                  "personal-bookmarks"
                ]
              },
              "currentVersion": 20
            }
          '';
        };
      };
    };
  };

  xdg.desktopEntries.ytMusic = {
    name = "YouTube Music";
    exec = "handlr launch x-scheme-handler/https -- --new-window https://music.youtube.com";
    icon = root + /assets/icons/yt-music.svg;
  };
}
