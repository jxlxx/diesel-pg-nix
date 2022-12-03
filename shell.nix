let
  rustOverlay = import (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz");
  pkgs = import <nixpkgs> { overlays = [ rustOverlay ]; };
  rustVersion = pkgs.rust-bin.stable.latest.default;
in
pkgs.mkShell {
  buildInputs = [
        (rustVersion.override {extensions = [ "rust-src" ]; })
        pkgs.diesel-cli
        pkgs.postgresql
    ];
  shellHook = ''
      chmod a+x ./bin/*;
      export PGHOST=$PWD/postgres
      export PGDATA=$PWD/postgres_data
      export PGDATABASE=diesel_demo
      export PGLOG=$PGHOST/postgres.log
  '';
}
