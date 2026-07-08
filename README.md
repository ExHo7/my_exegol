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
| **Dalfox**  | Dalfox xss detection |
| **Sliver GUI** | Prebuilt Wails GUI client + on-demand v1.7.3 teamserver |

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
| `sliver-gui-server` | Downloads/starts the Sliver v1.7.3 teamserver + generates the operator config |

### Sliver GUI

The prebuilt [`sliver-gui`](https://github.com/Mr-In4inci3le/sliver-gui) binary is shipped
in `bin/` and deployed to `/opt/my-resources/bin/sliver-gui` (on the container `PATH`).
Its GTK/WebKit runtime dependencies are installed automatically on the first container
startup via `conf/apt-packages.list`.

The GUI is only the **client**. It is built against Sliver **v1.7.3** protobufs, so it
needs a matching v1.7.3 teamserver — the Sliver bundled in Exegol is older and makes the
`Generate` panel fail (protobuf field mismatch). Use the helper to spin up the right
server on demand:

```sh
sliver-gui-server   # first call downloads the v1.7.3 server (~260MB, cached), starts the daemon + writes /root/op17.cfg
sliver-gui          # open the GUI → Pick config → /root/op17.cfg → Connect
```

The v1.7.3 server runs isolated in `/root/.sliver-17` and does not touch Exegol's bundled
Sliver. In the GUI, set the C2 URL manually (e.g. `mtls://127.0.0.1:8443`) for `Generate`.
