docker run --rm -it fedora:45 /bin/bash -c '
  set -e
  echo "=== Testing Fedora/DNF Integration ==="

  # 2. Inject repository configuration file block
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

  dnf -y makecache
  # 4. Check if your packages are reachable and queryable
  echo "=== Available Target Packages ==="
  dnf  repoquery --repo="aceofsnakes"

'
