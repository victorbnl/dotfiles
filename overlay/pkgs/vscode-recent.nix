{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  cairo,
  glib,
  pango,
  sqlite,
}:

rustPlatform.buildRustPackage rec {
  pname = "vscode-recent";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "fuljo";
    repo = "rofi-vscode-mode";
    rev = "v${version}";
    hash = "sha256-krP4yXCPZC455WHOh49he6nfE8ZaEbXv8xQKqRsWoy8=";
  };

  cargoHash = "sha256-RNeFhq2LOCEYpOaqfjLiF+S7DtFti15S43dVvRFACCE=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    cairo
    glib
    pango
    sqlite
  ];

  meta = {
    description = "A Rofi plugin to open recent VSCode workspaces";
    homepage = "https://github.com/fuljo/rofi-vscode-mode";
    changelog = "https://github.com/fuljo/rofi-vscode-mode/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = [];
    mainProgram = "vscode-recent";
  };
}
