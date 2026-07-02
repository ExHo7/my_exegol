# my_exegol

Personal configuration and resources for [Exegol](https://github.com/ThePorgs/Exegol). This repository automates the installation of tools, aliases, tmux/netexec configurations taken from [Frozenka](https://github.com/Frozenka/Exegol-Ressources)'s repo 🙏 through Exegol's `my-resources` feature. It's a lightweight config bundling personal tooling.

## Installation

From your host:

```sh
wget -qO- https://raw.githubusercontent.com/ExHo7/my_exegol/master/install.sh | bash
```

The `install.sh` script copies the configuration files into `~/.exegol/my_resources/`. The `load_user_setup.sh` file then runs on the first startup of each new container.

## What gets installed

`load_user_setup.sh` automatically provisions:

| Tool / Config | Description |
|---------------|-------------|
| **HTBRecon** | Hack The Box recon tool |
| **Claude Code** | Claude CLI |
| **Tmux plugins (tpm)** | tmux plugin manager |
| **SSTImap** | SSTI injection detection and exploitation |
| **NetExec** | `nxc.conf` configuration |

## Configurations

### tmux (`conf/tmux.conf`)

- Mouse enabled in tmux
- Copy selection on left click, paste on right click
- Split into four panes with `Ctrl+b '`
- Close active sessions with `Ctrl+b x`
- Status bar: date, IP (eth0/wlo1/tun0), public IP, connections, CPU, RAM

### Aliases (`conf/aliases`)

| Alias | Action |
|-------|--------|
| `tun0` / `eth0` | Copies the interface IP to the clipboard |
| `runftp` | FTP server (`pyftpdlib`) |
| `runsmbserv` | SMB server + `net use` command copied |
| `pty` | Copies a Python PTY spawn one-liner |
| `phpshell` | Copies a PHP webshell |
| `responder` | Responder on eth0 |
| `sstimap` | Runs SSTImap |
| `getfr` / `getrdp` | Copies PowerShell commands (FR locale / RDP enable) |
