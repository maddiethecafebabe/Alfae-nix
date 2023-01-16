{
  lib,
  fetchFromGitHub,
  buildDotnetModule,
  dotnetCorePackages,
  xorg,
  fontconfig,
  xdg-utils, # for xdg-open
  steamSupport ? true,
  steam-run,
}:
buildDotnetModule rec {
  pname = "Alfae";
  version = "1.3.2";

  src = fetchFromGitHub {
    owner = "suchmememanyskill";
    repo = pname;
    rev = version;
    hash = "sha256-WGcxGTM8uuTFXVQlYCy4ZREALN43AngPLlnsLUK8dFM=";
  };

  dotnet-sdk = dotnetCorePackages.sdk_7_0;
  dotnet-runtime = dotnetCorePackages.runtime_7_0;

  projectFile = "Launcher.sln";
  nugetDeps = ./deps.nix;

  runtimeDeps = with xorg; [libSM libICE libX11] ++ [fontconfig xdg-utils] ++ (lib.optionals steamSupport [steam-run]);

  postFixup = ''
    for plugin in $(cat Plugins.txt); do
        mkdir -p $out/lib/Alfae/plugins/$plugin
        cp $out/lib/Alfae/''${plugin}.dll $out/lib/Alfae/plugins/$plugin/
    done
  '';

  meta = {
    description = "An Itch.io/Epic Games/GOG launcher that works through plugins";
    license = with lib.licenses; [gpl3];
  };
}
