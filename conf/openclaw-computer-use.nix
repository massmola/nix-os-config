{ pkgs, openclaw }:

# Nix's strip phase changes the CUA binaries and invalidates OpenClaw's
# pinned SHA-256 checks. Restore the exact upstream artifacts in a separate
# package, and supply shared libraries through the wrapper instead of patching
# the binaries. OpenClaw's version and digest checks remain intact.
assert openclaw.version == "2026.9.5";
assert pkgs.stdenv.hostPlatform.system == "x86_64-linux";
let
  driver = pkgs.fetchurl {
    url = "https://registry.npmjs.org/@trycua/cua-driver-linux-x64-gnu/-/cua-driver-linux-x64-gnu-0.24.0.tgz";
    hash = "sha256-wX+yrTkzTTarff0lAh5RCRlcdmw/mpzRh1mAddGZQgM=";
  };
  libraries = pkgs.lib.makeLibraryPath [
    pkgs.libX11
    pkgs.libXi
    pkgs.libxkbcommon
    pkgs.stdenv.cc.cc.lib
  ];
in
pkgs.runCommand "openclaw-${openclaw.version}-computer-use" {
  inherit (openclaw) version meta;
  nativeBuildInputs = [ pkgs.makeWrapper ];
} ''
  mkdir -p "$out/lib" "$out/bin"
  cp -a --reflink=auto ${openclaw}/lib/openclaw "$out/lib/openclaw"
  driver_dir="$out/lib/openclaw/node_modules/.pnpm/@trycua+cua-driver-linux-x64-gnu@0.24.0/node_modules/@trycua/cua-driver-linux-x64-gnu"
  chmod u+w "$driver_dir" "$driver_dir/cua_driver_node_runtime.node" "$driver_dir/libcua_driver_sdk.so"
  tar -xzf ${driver} --strip-components=1 -C "$driver_dir" \
    package/cua_driver_node_runtime.node package/libcua_driver_sdk.so
  (
    cd "$driver_dir"
    sha256sum --check <<'HASHES'
  1f805d6052ee6c4f5ed3828ecbdf6e0db1f40f4e2fedcd292226e131a307c547  cua_driver_node_runtime.node
  6a63c34d9551c74eb15c6e304c5558d9b96c93bd59facaa5cd1a3c8c0eeedddd  libcua_driver_sdk.so
  HASHES
  )
  makeWrapper ${pkgs.nodejs}/bin/node "$out/bin/openclaw" \
    --add-flags "$out/lib/openclaw/dist/entry.js" \
    --prefix LD_LIBRARY_PATH : ${libraries}
''
