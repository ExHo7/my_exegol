# my_exegol

Personal configuration and resources for [Exegol](https://github.com/ThePorgs/Exegol). This repository automates the installation of tools, aliases, tmux/netexec configurations and a DNS recon script taken from [Frozenka](https://github.com/Frozenka/Exegol-Ressources)'s repo 🙏 through Exegol's `my-resources` feature. It's a lightweight config bundling personal tooling.

## Contents

```
my_exegol/
├── install.sh                    # Resources installation script
├── bash/
│   ├── getdns.sh                 # DNS recon: dnsvalidator + amass
│   └── load_user_setup.sh        # Setup run on the container's first startup
└── conf/
    ├── aliases                   # Personal zsh aliases
    ├── nxc.conf                  # NetExec configuration
    └── tmux.conf                 # Enhanced tmux configuration
```

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
| **DNS Validator** | `getdns.sh` DNS recon script |
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
| `runwww` | HTTP upload server (`uploadserver`) |
| `runftp` | FTP server (`pyftpdlib`) |
| `runwebdav` | WebDAV server |
| `runsmbserv` | SMB server + `net use` command copied |
| `pty` | Copies a Python PTY spawn one-liner |
| `phpshell` | Copies a PHP webshell |
| `getdns` | Runs the DNS recon |
| `responder` | Responder on eth0 |
| `sstimap` | Runs SSTImap |
| `getfr` / `getrdp` | Copies PowerShell commands (FR locale / RDP enable) |

### getdns.sh

Automated DNS recon:
1. Generates a list of valid resolvers with `dnsvalidator`
2. Waits for 50 resolvers then runs `amass enum` in bruteforce mode against the provided FQDN
3. Output in `/tmp/domains.txt`

```sh
getdns
# Enter the FQDN: example.com
```
