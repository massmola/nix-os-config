error 1 
```
Job for home-manager-spatola.service failed because the control process exited with error code.
See "systemctl status home-manager-spatola.service" and "journalctl -xeu home-manager-spatola.service" for details.
```
error 2
```
mag 03 11:23:56 marvin hm-activate-spatola[6232]: Existing file '/home/spatola/.config/hypr/hyprland.conf' is in the way of '/nix/store/65qv8045hzsmnr127k2c55n0zm6yznl5-home-manager-files/.config/hypr/hyprland.conf'
mag 03 11:23:56 marvin hm-activate-spatola[6232]: Please move the above files and try again or use 'home-manager switch -b backup' to back up existing files automatically.
mag 03 11:23:56 marvin systemd[1]: home-manager-spatola.service: Main process exited, code=exited, status=1/FAILURE
mag 03 11:23:56 marvin systemd[1]: home-manager-spatola.service: Failed with result 'exit-code'.
mag 03 11:23:56 marvin systemd[1]: Failed to start Home Manager environment for spatola.
```