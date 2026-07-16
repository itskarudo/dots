flake := justfile_directory()

default:
    @just --list

switch:
    @if [ "$(uname)" = "Darwin" ]; then nh darwin switch {{flake}}; else nh os switch {{flake}}; fi

build:
    @if [ "$(uname)" = "Darwin" ]; then nh darwin build {{flake}}; else nh os build {{flake}}; fi

fmt:
    nix fmt

update:
    nix flake update

bump input:
    nix flake update {{input}}

lint:
    nix run --inputs-from {{flake}} nixpkgs#statix -- check .
    nix run --inputs-from {{flake}} nixpkgs#deadnix -- --fail .

gc:
    nh clean all --keep 5 --keep-since 7d
