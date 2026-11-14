docker run --rm -it opensuse/${1:-tumbleweed} /bin/bash -c '
  set -e
  echo -e "\n=== Testing openSUSE/Zypper Integration ===\n"
  
  # 1. Install falling network dependencies
  zypper --non-interactive install curl
  
  # 2. Inject repository file configuration block
  tee /etc/zypp/repos.d/aceofsnakes.repo <<EOF
[aceofsnakes]
name=Ace Of Snakes Repository
baseurl=https://aceofsnakes.github.io/rpm/
type=rpm-md
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://aceofsnakes.github.io/rpm/repomd.qg.key
EOF

  # 3. Refresh metadata indexes and cache repository keys
  zypper --no-gpg-checks refresh aceofsnakes
  
  # 4. Search package streams from your origin key target
  echo -e "\n=== Available Target Packages ===\n"
  zypper packages --repo aceofsnakes
'
