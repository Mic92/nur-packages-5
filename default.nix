with import <stockholm/lib>;
self: super: let

  # This callPackage will try to detect obsolete overrides.
  callPackage = path: args: let
    override = super.callPackage path args;
    upstream = optionalAttrs (override ? "name")
      (super.${(parseDrvName override.name).name} or {});
  in if upstream ? "name" &&
        override ? "name" &&
        compareVersions upstream.name override.name != -1
    then
      trace
        "Upstream `${upstream.name}' gets overridden by `${override.name}'."
        override
    else override;

in {
    alsa-hdspconf = callPackage ./alsa-tools { alsaToolTarget="hdspconf";};
    alsa-hdspmixer = callPackage ./alsa-tools { alsaToolTarget="hdspmixer";};
    alsa-hdsploader = callPackage ./alsa-tools { alsaToolTarget="hdsploader";};
    inherit (callPackage ./devpi {}) devpi-web devpi-server devpi-client;
    nodemcu-uploader = callPackage ./nodemcu-uploader {};
    pwqgen-ger = callPackage <stockholm/krebs/5pkgs/simple/passwdqc-utils> {
      wordset-file = pkgs.fetchurl {
        url = https://gist.githubusercontent.com/makefu/b56f5554c9ef03fe6e09878962e6fd8d/raw/1f147efec51325bc9f80c823bad8381d5b7252f6/wordset_4k.c ;
        sha256 = "18ddzyh11bywrhzdkzvrl7nvgp5gdb4k1s0zxbz2bkhd14vi72bb";
      };
    };

}

// mapAttrs (_: flip callPackage {})
            (filterAttrs (_: dir: pathExists (dir + "/default.nix"))
                         (subdirsOf ./.))
