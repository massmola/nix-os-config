# NixOS Configuration (Marvin)

This repository contains the NixOS system configuration for the host **marvin**, managing user environments for **spatola** and **ict** using `home-manager`.

## Structure

```txt
.
├── conf
│   ├── configuration.nix           # Main system configuration
│   └── hardware-configuration.nix  # Hardware-specific configuration
├── home
│   ├── common.nix                  # Shared home-manager configuration
│   ├── flake                       # (Directory)
│   ├── ict.nix                     # User configuration for 'ict'
│   ├── spatola.nix                 # User configuration for 'spatola'
│   └── vscode_settings.json        # VS Code settings
├── flake.lock
├── flake.nix                       # Flake entry point
├── README.md                       # This file
└── rebuild.sh                      # System rebuild script
```

## Usage

Use the `rebuild.sh` script to apply changes and rebuild the system.

```bash
./rebuild.sh "<commit_message>" [issue_number] [--update]
```

### Arguments

- `<commit_message>`: Description of the changes made.
- `[issue_number]`: *(Optional)* Issue number to link the commit to (e.g., `42` becomes `#42` in the commit).
- `[--update]`: *(Optional)* Updates the flake inputs before rebuilding.

### Examples

**Standard rebuild:**
```bash
./rebuild.sh "Update system packages"
```

**Rebuild and link to issue #12:**
```bash
./rebuild.sh "Fix audio configuration" 12
```

**Update flake inputs and rebuild:**
```bash
./rebuild.sh "Update all inputs" --update
```