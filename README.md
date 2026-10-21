# NixOS System Configuration

This repository contains a declarative, modular, and reproducible NixOS configuration managed via Flakes. It is designed to scale across multiple machines (laptops, desktops, servers) and multiple users while maintaining a clean separation of concerns and strict security boundaries.

## Summary

- [Features](#features)
- [Repository Structure](#repository-structure)
- [Getting Started](#getting-started)
- [Adding a New Host Manualy](#adding-a-new-host-manualy)
    - [1. Hardware and Disk Configuration](#1-hardware-and-disk-configuration) 
    - [2. System Configuration](#2-system-configuration)
    - [3. Flake Integration](#3-flake-integration)
    - [4. System Secrets Management (SOPS)](#4-system-secrets-management-sops)
    - [5. Installing the System](#5-installing-the-system)
- [Adding a User](#adding-a-user)
    - [1. Generate User Secrets Infrastructure](#1-generate-user-secrets-infrastructure)
    - [2. Create the User Profile](#2-create-the-user-profile)
    - [3. Declare the User in the Host](#3-declare-the-user-in-the-host)
- [Troubleshooting](#troubleshooting)
    - [Recovery](#recovery)
- [License](#license)

## Features

* **Architecture** based on Nix Flakes for strict reproducibility.
* **Two-Key Secrets Management** using `sops-nix` (Age/SSH keys), strictly separating root-owned system secrets from unprivileged user-specific secrets.
* **Declarative Disk Partitioning** and formatting via Disko (LUKS encryption + BTRFS subvolumes).
* **User Environment Management** through Home Manager.
* **Wayland-Native Desktop Environments** with Sway/SwayFX.
* **Reusable Module System** separating system logic (NixOS) from user logic (Home Manager), alongside dynamic host-aware configurations. 

## Repository Structure

The repository is organized to strictly separate system configurations, user profiles, and reusable components:

* `flake.nix` & `flake.lock`: The entry points of the configuration, defining dependencies and available hosts.
* `hosts/`: Contains machine-specific configurations. Each subdirectory represents a machine and includes its `hardware-configuration.nix`, `disko.nix`, and local `configuration.nix`.
* `modules/`: Contains reusable NixOS system modules (e.g., core utilities, networking, desktop environment services). These affect the system globally.
* `users/`: Contains user identities and their specific Home Manager profiles (e.g., `server.nix`, `desktop.nix`), including dynamic hardware-aware configurations.
* `home/`: Contains reusable Home Manager modules (e.g., Zsh config, Neovim, Wayland compositors). These affect only the user environment.
* `secrets/`: Contains encrypted files managed by SOPS, split into `shared.yaml`, and user-specific files.
* `lib/`: Contains custom Nix helper functions (e.g., automatic path scanning).

## Getting Started

To apply this configuration to an existing machine already defined in the flake:

1. **Clone the repository:**
   ```bash
   git clone <repository-url> /etc/nixos-config
   cd /etc/nixos-config
   ```
2. **Ensure your SOPS age keys are present:**
    - System Key: Must be located at `/var/lib/sops-nix/keys.txt` (read by root during boot).
    - User Key: Must be located at `~/.config/sops/age/keys.txt` (read by Home Manager).
3. **Apply the configuration:**
    ```bash
    sudo nixos-rebuild switch --flake .#<hostname>
    ```

## Adding a New Host Manualy

Adding a new machine requires setting up its hardware profile, its disk layout, its system configuration, and its cryptographic keys for secret management.

### 1. Hardware and Disk Configuration

- Boot the new machine using a NixOS live USB.
- (help) : you can switch the keyboard layout to French with `sudo loadkeys fr` and you can setup your connection with `nmtui`.

#### Using SSH (Recomanded):

Setting up the new machine in the tty can be annoying, the usage of ssh is recomanded. To do that, you can set your own public key in the ssh authorisedKeys (e.g., cloud-init) or you can do it with a password using
```bash 
passwd
```
and then connection from a remote machine with
```bash
ssh nixos@<new-host-ip>
```

- Clone the repository
   ```bash
   git clone <repository-url> /etc/nixos-config
   cd /etc/nixos-config
   ```
- Generate the hardware configuration and add it to git:
    ```bash
    nixos-generate-config --no-filesystems --show-hardware-config > hosts/<new-host>/hardware-configuration.nix
    ```
- Create a `disko.nix` file in `hosts/<new-host>/` and add it to git. You can copy an existing one and adjust it. After that, run the following command to apply the disk configuration:
    ```bash
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./host/<nom_host>/disko.nix
    ```

### 2. System Configuration

- Create `hosts/<new-host>/configuration.nix` and add it to git. You can copy an existing one and adjust it as follow
- Import the necessary modules (hardware, disko, core modules, ...).
- Define the hostname, bootloader settings, and state version.
- Declare the users that will exist on this machine and link their Home Manager profiles if needed.

### 3. Flake Integration

- Open `flake.nix`.
- Add a new block in the nixosConfigurations set using the system builder function:
    ```nix
    <new-host> = mkSystem {
        hostname = "<new-host>";
        system = "x86_64-linux";
    };
    ```

### 4. System Secrets Management (SOPS)

To allow the new host to decrypt system-level secrets (like WiFi/VPN passwords):

- Retrieve the machine's public SSH ed25519 key (found in `/etc/ssh/ssh_host_ed25519_key.pub`).
- On an other machine, convert it to an age public key using `ssh-to-age`:
    ```bash
    ssh-keyscan <new-host-ip> | ssh-to-age
    ```
- Define in `.sops.yaml` available at the root of the repository, the new public key to the keys section.
- Add the new key reference to the appropriate `creation_rules`.
- Re-encrypt the existing system secrets to include the new host:
    ```bash
    sops updatekeys secrets/<file>.yaml
    ```
- On the new host, copy the keys files automaticly generated by the host to the future mounted partition:
    ```bash
    sudo cp /etc/ssh/ssh_host* /mnt/etc/ssh
    ```
- Generate and copy the age key file too:
    ```bash
    nix-shell -p ssh-to-age
    sudo bash -c 'cd /etc/ssh && mkdir -p /mnt/var/lib/sops-nix && PRIV_KEY=$(ssh-to-age -private-key -i ssh_host_ed25519_key) && \
    PUB_KEY=$(ssh-to-age -i ssh_host_ed25519_key.pub 2>/dev/null || echo "$PRIV_KEY" | age-keygen -y) && \
    printf "# public key: %s\n%s\n" "$PUB_KEY" "$PRIV_KEY" > /mnt/var/lib/sops-nix/keys.txt && \
    chmod 600 /mnt/var/lib/sops-nix/keys.txt'
    ```

### 5. Installing the System

Now that everything is configured, we can proced to the installation:

```bash
sudo nixos-install --flake .#<new-host>
```

## Adding a User

Users are built using a profile-based approach, allowing the same user to have a graphical interface on a laptop and a minimal CLI on a server, while securely isolating their personal secrets.

### 1. Generate User Secrets Infrastructure

Before creating the profile, initialize the user's secure enclave:

- Generate a user-specific Age key:
    ```bash
    mkdir -p ~/.config/sops/age
    age-keygen -o ~/.config/sops/age/keys.txt
    ```
- Open .sops.yaml, add the new key to the keys section.
- Add a new creation rule for the user's private secrets with the appropriate key reference:
    ```yaml
    - path_regex: secrets/<new-user>\.yaml$
      key_groups:
        - age:
            - "<new-user-public-age-key-reference>"
    ```
- Create the user's secret file:
```bash
sops secrets/<new-user>.yaml
```

### 2. Create the User Profile

- Create a directory for the new user: `users/<new-user>/`.
- Create profile files depending on the needs (e.g., server.nix, desktop.nix).
- Import the needed home modules. You can copy a similar one and adjust it.

### 3. Declare the User in the Host

- Open the `configuration.nix` of the host where this user should exist.
- Declare the system user:
    ```nix
    users.users."<new-user>" = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ]; 
    };
    ```
- Assign the Home Manager profile to this user on this specific host:
    ```nix
    home-manager.users."<new-user>" = import ../../users/<new-user>/server.nix;
    ```

## Troubleshooting

### Recovery

If you loose acces to the machine and booting on a previous version is not possible. You can enter a "Recovery Mode" by booting on live usb with a minimal nixos and mounting the system partitions and then enter the system to make the changement you need:

```bash
mount /dev/nvme0n1p1 /mnt
mount /dev/nvme0n1p2 /mnt/boot # If the boot is on its own partition
sudo nixos-enter
# don't forget to exit and then un mount the partitions
umount /mnt
```

## License

This project is licensed under the MIT License. See the `LICENSE` file for more informations
