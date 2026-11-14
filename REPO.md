## Debian / Ubuntu (APT) Installation

Add the repository GPG key and register the source line:

```sh
curl -fsSL https://aceofsnakes.github.io/aceofsnakes.gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/aceofsnakes.gpg
sudo tee /etc/apt/sources.list.d/aceofsnakes.sources <<EOF
X-Repolib-Name: Ace Of Snakes Repository
Types: deb
URIs: https://aceofsnakes.github.io/apt/
Suites: stable
Components: main
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/aceofsnakes.gpg
EOF

sudo apt update
```
## RHEL / Fedora / Rocky Linux (DNF) Installation

Create a repository configuration file under `/etc/dnf.repos.d/`: 
```sh
sudo tee /etc/yum.repos.d/aceofsnakes.repo <<EOF
[aceofsnakes]
name=Ace Of Snakes Repository \$basearch
baseurl=https://aceofsnakes.github.io/rpm/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://aceofsnakes.github.io/rpm/repomd.qg.key
includepkgs=*.\$basearch,*.noarch
EOF

sudo dnf check-update
```

## openSUSE / SLES (Zypper) Installation

Create a repository configuration file under `/etc/zypp/repos.d/`:
```sh
sudo tee /etc/zypp/repos.d/aceofsnakes.repo <<EOF
[aceofsnakes]
name=Ace Of Snakes Repository
baseurl=https://aceofsnakes.github.io/rpm/
type=rpm-md
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://aceofsnakes.github.io/rpm/repomd.qg.key
EOF

sudo zypper refresh
```

         <!--div class="floating-footer">
                <div class="footer-content">
                    <span>© 2026 Ace Of Snakes</span>
                    <div class="footer-links">
                        <a href="https://aceofsnakes.github.io/apt/pool/main">Browse DEB Packages</a>
                        <a href="https://aceofsnakes.github.io/rpm/">Browse RPM Packages</a>
                    </div>
                </div>
            </div-->
