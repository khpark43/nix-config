{ pkgs, config, ... }: {
  services.gpg-agent = {
    enable = true;
    enableExtraSocket = true;
    pinentryPackage = if config.gtk.enable then pkgs.pinentry-gnome3 else pkgs.pinentry-tty;
  };
  programs.gpg.enable = true;

  home.packages = [ pkgs.gcr ];
}

