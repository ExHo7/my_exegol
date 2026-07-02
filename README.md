# my_exegol

Configuration personnelle et ressources pour [Exegol](https://github.com/ThePorgs/Exegol), l'environnement de pentest. Ce dépôt automatise l'installation d'outils, d'alias, de configurations tmux/netexec et d'un script de recon DNS via la fonctionnalité `my-resources` d'Exegol.

## Contenu

```
my_exegol/
├── install.sh                    # Script d'installation des ressources
├── bash/
│   ├── getdns.sh                 # Recon DNS : dnsvalidator + amass
│   └── load_user_setup.sh        # Setup exécuté au 1er démarrage du conteneur
└── conf/
    ├── aliases                   # Alias zsh personnels
    ├── nxc.conf                  # Configuration NetExec
    └── tmux.conf                 # Configuration tmux améliorée
```

## Installation

Depuis un conteneur Exegol avec la feature `my-resources` activée :

```sh
wget -qO- https://raw.githubusercontent.com/ExHo7/my_exegol/master/install.sh | bash
```

Le script `install.sh` copie les fichiers de configuration dans `~/.exegol/my_resources/`. Le fichier `load_user_setup.sh` s'exécute ensuite au premier démarrage de chaque nouveau conteneur.

## Ce qui est installé

`load_user_setup.sh` provisionne automatiquement :

| Outil / Config | Description |
|----------------|-------------|
| **HTBRecon** | Outil de recon Hack The Box |
| **Claude Code** | CLI Claude |
| **Tmux plugins (tpm)** | Gestionnaire de plugins tmux |
| **SSTImap** | Détection et exploitation d'injections SSTI |
| **DNS Validator** | Script `getdns.sh` de recon DNS |
| **NetExec** | Configuration `nxc.conf` |

## Configurations

### tmux (`conf/tmux.conf`)

- Souris activée dans tmux
- Copier la sélection au clic gauche, coller au clic droit
- Split en quatre panneaux avec `Ctrl+b '`
- Fermer les sessions actives avec `Ctrl+b x`
- Barre de statut : date, IP (eth0/wlo1/tun0), IP publique, connexions, CPU, RAM

### Alias (`conf/aliases`)

| Alias | Action |
|-------|--------|
| `tun0` / `eth0` | Copie l'IP de l'interface dans le presse-papiers |
| `runwww` | Serveur HTTP d'upload (`uploadserver`) |
| `runftp` | Serveur FTP (`pyftpdlib`) |
| `runwebdav` | Serveur WebDAV |
| `runsmbserv` | Serveur SMB + commande `net use` copiée |
| `pty` | Copie un one-liner spawn PTY Python |
| `phpshell` | Copie un webshell PHP |
| `getdns` | Lance la recon DNS |
| `responder` | Responder sur eth0 |
| `sstimap` | Lance SSTImap |
| `getfr` / `getrdp` | Copie des commandes PowerShell (locale FR / activation RDP) |

### getdns.sh

Recon DNS automatisé :
1. Génère une liste de résolveurs valides avec `dnsvalidator`
2. Attend 50 résolveurs puis lance `amass enum` en bruteforce sur le FQDN fourni
3. Sortie dans `/tmp/domains.txt`

```sh
getdns
# Entrez le FQDN : exemple.com
```
