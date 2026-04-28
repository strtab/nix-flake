{ pkgs, ... }:
{
  boot = {
    consoleLogLevel = 0;
    initrd = {
      verbose = false;
      systemd.enable = true;
    };
    plymouth = {
      enable = true;
      theme = "nixos";
      package = pkgs.plymouth.overrideAttrs (old: {
        postInstall = (old.postInstall or "") + ''
          mkdir -p $out/share/plymouth/themes/nixos/images
          cp ${./nixos.plymouth} $out/share/plymouth/themes/nixos/nixos.plymouth
          cp ${./nixos.script}   $out/share/plymouth/themes/nixos/nixos.script
          cp ${./images/bullet.png}       $out/share/plymouth/themes/nixos/images/bullet.png
          cp ${./images/entry.png}        $out/share/plymouth/themes/nixos/images/entry.png
          cp ${./images/lock.png}         $out/share/plymouth/themes/nixos/images/lock.png
          cp ${./images/logo.png}         $out/share/plymouth/themes/nixos/images/logo.png
          cp ${./images/progress_bar.png} $out/share/plymouth/themes/nixos/images/progress_bar.png
          cp ${./images/progress_box.png} $out/share/plymouth/themes/nixos/images/progress_box.png
          cp ${./images/animation.png} $out/share/plymouth/themes/nixos/images/animation.png
          cp ${./images/background.png} $out/share/plymouth/themes/nixos/images/background.png
          cp ${./images/box.png} $out/share/plymouth/themes/nixos/images/box.png
          cp ${./images/motif.png} $out/share/plymouth/themes/nixos/images/motif.png
          cp ${./images/progress_box_background.png} $out/share/plymouth/themes/nixos/images/progress_box_background.png
          cp ${./images/progress_box_edge.png} $out/share/plymouth/themes/nixos/images/progress_box_edge.png
          cp ${./images/suspend.png} $out/share/plymouth/themes/nixos/images/suspend.png
        '';
      });
    };
    kernelParams = [
      "quiet"
      "splash"
      "udev.log_level=3"
      "rd.udev.log_level=3"
      "systemd.show_status=false"
      "vt.global_cursor_default=0"
    ];
  };
}
