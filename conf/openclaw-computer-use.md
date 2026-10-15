# OpenClaw Linux desktop control

The system OpenClaw 2026.9.5 package strips the native CUA SDK files. This
changes their hashes, so the built-in artifact verification rejects them.
`openclaw-computer-use.nix` repackages that version with the original, pinned
npm artifacts and supplies X11 libraries through `LD_LIBRARY_PATH`. It keeps
OpenClaw's native-file integrity verification intact.

Build from the repository root:

```bash
nix build --impure --no-link --print-out-paths --expr '
  let
    f = builtins.getFlake (toString ./.);
    pkgs = f.inputs.nixpkgs.legacyPackages.x86_64-linux;
  in import ./conf/openclaw-computer-use.nix {
    inherit pkgs;
    openclaw = f.inputs.llm-agents.packages.x86_64-linux.openclaw;
  }
'
```

Install the printed store path using `nix profile add <store-path>`, then:

```bash
openclaw plugins enable cua-computer
openclaw doctor --lint --only cua-computer/driver-artifacts
```

The corrected package has been installed in spatola's user profile. The system
package remains available at `/run/current-system/sw/bin/openclaw`.

Verified on 2026-10-12: artifact checks pass and the SDK loads and detects the
display. Capturing the current GNOME Wayland session fails with an X11 GetImage
BadMatch error. Display detection alone does not prove desktop control works.
Use an X11 desktop session, or a separate X11 virtual desktop, and verify actual
capture before enabling tasks that send desktop input.

A temporary Xvfb X11 display passed actual screen capture on 2026-10-12. The
test display was stopped afterward. Mouse and keyboard actions remain untested.

The plugin is explicitly enabled in `~/.openclaw/openclaw.json`, and the
`computer` tool is allowed. A local, token-authenticated Gateway is installed
as `openclaw-gateway.service` in the user session and enabled at login. Its
wrapper uses the corrected package from the user profile. It listens only on
127.0.0.1 / ::1 port 18789; the authenticated health check passed on 2026-10-12.
Open the dashboard with `openclaw dashboard`. The existing ChatGPT OAuth
sign-in was imported using `openclaw models auth login --provider openai
--device-code`; `openclaw models status --check` passes for the default
`openai/gpt-6-astra` model. Desktop input has not been verified.
A live OAuth model probe succeeded on 2026-10-12, and the Gateway was restarted
afterward to pick up the account connection.

This workaround is deliberately limited to OpenClaw 2026.9.5 on x86_64 Linux.
An upgrade must review the driver version, archive hash, and native-file hashes.
