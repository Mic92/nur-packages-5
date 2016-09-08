{ pkgs, ... }:

let
  inherit (pkgs) callPackage;
  nixpkgs-1509 = import (pkgs.fetchFromGitHub {
    owner = "NixOS"; repo = "nixpkgs-channels";
    rev = "91371c2bb6e20fc0df7a812332d99c38b21a2bda";
    sha256 = "1as1i0j9d2n3iap9b471y4x01561r2s3vmjc5281qinirlr4al73";
  }) {};

in
{
  nixpkgs.config.packageOverrides = rec {
    cups = nixpkgs-1509.cups;
    alsa-hdspconf = callPackage ./alsa-tools { alsaToolTarget="hdspconf";};
    alsa-hdspmixer = callPackage ./alsa-tools { alsaToolTarget="hdspmixer";};
    alsa-hdsploader = callPackage ./alsa-tools { alsaToolTarget="hdsploader";};
    awesomecfg = callPackage ./awesomecfg {};
    bintray-upload = callPackage ./bintray-upload {};
    inherit (callPackage ./devpi {}) devpi-web devpi-server;
    f3 = callPackage ./f3 {};
    farpd = callPackage ./farpd {};
    git-xlsx-textconv = callPackage ./git-xlsx-textconv {};
    mergerfs = callPackage ./mergerfs {};
    mycube-flask = callPackage ./mycube-flask {};
    nodemcu-uploader = callPackage ./nodemcu-uploader {};
    ps3netsrv = callPackage ./ps3netsrv {};
    pwqgen-ger = callPackage ../../krebs/5pkgs/passwdqc-utils {
      wordset-file = pkgs.fetchurl {
        url = https://gist.githubusercontent.com/makefu/b56f5554c9ef03fe6e09878962e6fd8d/raw/1f147efec51325bc9f80c823bad8381d5b7252f6/wordset_4k.c ;
        sha256 = "18ddzyh11bywrhzdkzvrl7nvgp5gdb4k1s0zxbz2bkhd14vi72bb";
      };
    };
    qcma = pkgs.qt5.callPackage ./qcma {};
    tw-upload-plugin = callPackage ./tw-upload-plugin {};
    skytraq-logger = callPackage ./skytraq-logger {};
    taskserver = callPackage ./taskserver {};
    udpt = callPackage ./udpt {};
    wol = callPackage ./wol {};
  };
}
