{
  description = "Shared kernel modelled after git concepts";
  inputs = rec {
    nixos.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils/v1.0.0";
    pythoneda-shared-pythoneda-domain = {
      url =
        "github:pythoneda-shared-pythoneda/domain-artifact/0.0.1a26?dir=domain";
      inputs.nixos.follows = "nixos";
      inputs.flake-utils.follows = "flake-utils";
    };
  };
  outputs = inputs:
    with inputs;
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixos { inherit system; };
        description = "Shared kernel modelled after git concepts";
        license = pkgs.lib.licenses.gpl3;
        homepage = "https://github.com/pythoneda-shared-git/shared";
        maintainers = [ "rydnr <github@acm-sl.org>" ];
        nixpkgsRelease = "nixos-23.05";
        shared = import ./nix/shared.nix;
        pythoneda-shared-git-shared-for =
          { python, pythoneda-shared-pythoneda-domain, version }:
          let
            pname = "pythoneda-shared-git-shared";
            pnameWithUnderscores =
              builtins.replaceStrings [ "-" ] [ "_" ] pname;
            pythonpackage = "pythoneda.shared.git";
            pythonVersionParts = builtins.splitVersion python.version;
            pythonMajorVersion = builtins.head pythonVersionParts;
            pythonMajorMinorVersion =
              "${pythonMajorVersion}.${builtins.elemAt pythonVersionParts 1}";
            wheelName =
              "${pnameWithUnderscores}-${version}-py${pythonMajorVersion}-none-any.whl";
          in python.pkgs.buildPythonPackage rec {
            inherit pname version;
            projectDir = ./.;
            pyprojectTemplateFile = ./pyprojecttoml.template;
            pyprojectTemplate = pkgs.substituteAll {
              authors = builtins.concatStringsSep ","
                (map (item: ''"${item}"'') maintainers);
              desc = description;
              dulwichVersion = python.pkgs.dulwich.version;
              gitPythonVersion = python.pkgs.GitPython.version;
              inherit homepage pname pythonMajorMinorVersion pythonpackage
                version;
              package = builtins.replaceStrings [ "." ] [ "/" ] pythonpackage;
              paramikoVersion = python.pkgs.paramiko.version;
              pythonedaSharedPythonedaDomainVersion =
                pythoneda-shared-pythoneda-domain.version;
              semverVersion = python.pkgs.semver.version;
              src = pyprojectTemplateFile;
            };
            src = pkgs.fetchFromGitHub {
              owner = "pythoneda-shared-git";
              repo = "shared";
              rev = version;
              sha256 = "sha256-8egCpLIaHoLlKZgML/Mqk+n4br62rB3HZQcf6dIpq/A=";
            };

            format = "pyproject";

            nativeBuildInputs = with python.pkgs; [ pip pkgs.jq poetry-core ];
            propagatedBuildInputs = with python.pkgs; [
              dulwich
              GitPython
              paramiko
              pythoneda-shared-pythoneda-domain
              semver
            ];

            pythonImportsCheck = [ pythonpackage ];

            unpackPhase = ''
              cp -r ${src} .
              sourceRoot=$(ls | grep -v env-vars)
              chmod +w $sourceRoot
              cp ${pyprojectTemplate} $sourceRoot/pyproject.toml
            '';

            postInstall = ''
              pushd /build/$sourceRoot
              for f in $(find . -name '__init__.py'); do
                if [[ ! -e $out/lib/python${pythonMajorMinorVersion}/site-packages/$f ]]; then
                  cp $f $out/lib/python${pythonMajorMinorVersion}/site-packages/$f;
                fi
              done
              popd
              mkdir $out/dist
              cp dist/${wheelName} $out/dist
              jq ".url = \"$out/dist/${wheelName}\"" $out/lib/python${pythonMajorMinorVersion}/site-packages/${pnameWithUnderscores}-${version}.dist-info/direct_url.json > temp.json && mv temp.json $out/lib/python${pythonMajorMinorVersion}/site-packages/${pnameWithUnderscores}-${version}.dist-info/direct_url.json
            '';

            meta = with pkgs.lib; {
              inherit description homepage license maintainers;
            };
          };
        pythoneda-shared-git-shared-0_0_1a6-for =
          { python, pythoneda-shared-pythoneda-domain }:
          pythoneda-shared-git-shared-for {
            version = "0.0.1a6";
            inherit python pythoneda-shared-pythoneda-domain;
          };
      in rec {
        defaultPackage = packages.default;
        devShells = rec {
          default = pythoneda-shared-git-shared-latest;
          pythoneda-shared-git-shared-0_0_1a6-python38 = shared.devShell-for {
            package = packages.pythoneda-shared-git-shared-0_0_1a6-python38;
            python = pkgs.python38;
            pythoneda-shared-pythoneda-domain =
              pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-latest-python38;
            inherit pkgs nixpkgsRelease;
          };
          pythoneda-shared-git-shared-0_0_1a6-python39 = shared.devShell-for {
            package = packages.pythoneda-shared-git-shared-0_0_1a6-python39;
            python = pkgs.python39;
            pythoneda-shared-pythoneda-domain =
              pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-latest-python39;
            inherit pkgs nixpkgsRelease;
          };
          pythoneda-shared-git-shared-0_0_1a6-python310 = shared.devShell-for {
            package = packages.pythoneda-shared-git-shared-0_0_1a6-python310;
            python = pkgs.python310;
            pythoneda-shared-pythoneda-domain =
              pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-latest-python310;
            inherit pkgs nixpkgsRelease;
          };
          pythoneda-shared-git-shared-latest-python38 =
            pythoneda-shared-git-shared-0_0_1a6-python38;
          pythoneda-shared-git-shared-latest-python39 =
            pythoneda-shared-git-shared-0_0_1a6-python39;
          pythoneda-shared-git-shared-latest-python310 =
            pythoneda-shared-git-shared-0_0_1a6-python310;
          pythoneda-shared-git-shared-latest =
            pythoneda-shared-git-shared-latest-python310;
        };
        packages = rec {
          pythoneda-shared-git-shared-0_0_1a6-python38 =
            pythoneda-shared-git-shared-0_0_1a6-for {
              python = pkgs.python38;
              pythoneda-shared-pythoneda-domain =
                pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-latest-python38;
            };
          pythoneda-shared-git-shared-0_0_1a6-python39 =
            pythoneda-shared-git-shared-0_0_1a6-for {
              python = pkgs.python39;
              pythoneda-shared-pythoneda-domain =
                pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-latest-python39;
            };
          pythoneda-shared-git-shared-0_0_1a6-python310 =
            pythoneda-shared-git-shared-0_0_1a6-for {
              python = pkgs.python310;
              pythoneda-shared-pythoneda-domain =
                pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-latest-python310;
            };
          pythoneda-shared-git-shared-latest-python38 =
            pythoneda-shared-git-shared-0_0_1a6-python38;
          pythoneda-shared-git-shared-latest-python39 =
            pythoneda-shared-git-shared-0_0_1a6-python39;
          pythoneda-shared-git-shared-latest-python310 =
            pythoneda-shared-git-shared-0_0_1a6-python310;
          pythoneda-shared-git-shared-latest =
            pythoneda-shared-git-shared-latest-python310;
          default = pythoneda-shared-git-shared-latest;
        };
      });
}
