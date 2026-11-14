docker run --rm -it ubuntu:${1:-noble} /bin/bash -c '
  set -e
  echo -e "\n=== Testing Ubuntu/APT Integration ===\n"
  
  # 1. Install fallback networking tools
  apt update && apt install -y curl gnupg aptitude
  
  # 2. Add repository GPG key
  mkdir -p /etc/apt/keyrings
  curl -fsSL https://aceofsnakes.github.io/aceofsnakes.gpg | \
  gpg --dearmor -o /etc/apt/keyrings/aceofsnakes.gpg

  tee /etc/apt/sources.list.d/aceofsnakes.sources <<EOF
X-Repolib-Name: Ace Of Snakes Repository
Types: deb
URIs: https://aceofsnakes.github.io/apt/
Suites: stable
Components: main
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/aceofsnakes.gpg
EOF

  # 3. Pull signed database manifests
  apt update
  
  # 4. Check if your custom packages show up under cache policies
  #echo -e "\n=== Available Target Packages ===\n"
  # apt-cache policy netrc avrpioremote avrpioremote-qt5

  echo -e "\n=== Available Target Packages ===\n"
  aptitude search -F "%p" "?origin(Ace.Of.Snakes)" | xargs aptitude show
  echo -e "\n= Brief Available Target Packages =\n"
  aptitude search "?origin(\"Ace Of Snakes\")"
'
