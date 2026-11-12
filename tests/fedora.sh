docker run --rm -it fedora:45 /bin/bash -c '
  set -e
  echo "=== Testing Fedora/DNF Integration ==="
  
  # 1. Install fallback network download utilities
  dnf install -y curl
  #sudo dnf config-manager addrepo  https://wmp.github.io/

  
  # 2. Inject repository configuration file block
  ls -al /etc/dnf/*
  #ls -al /etc/libdnf5.conf.d
  #cat /etc/dnf.conf
  mkdir -p /etc/dnf/repos.d
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

  # 3. CRITICAL: Import your hosted GPG key into the RPM system keyring first
  # rpm --import https://aceofsnakes.github.io/rpm/repomd.qg.key
  sudo dnf config-manager setopt fedora-cisco-openh264.enabled=0
  
 # 3. Pull down metadata indexes and prompt signature check caches
  dnf -y makecache

  # 4. Check if your packages are reachable and queryable
  echo "=== Available Target Packages ==="
  dnf --disablerepo=* --enablerepo="aceofsnakes" list
  # dnf  --help
  #sudo dnf5 install netrc
'
