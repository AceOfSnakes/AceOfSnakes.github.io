docker run --rm -it ubuntu:noble /bin/bash -c '
  set -e
  echo "=== Testing Ubuntu/APT Integration ==="
  
  # 1. Install fallback networking tools
  apt-get update && apt-get install -y curl gnupg
  
  # 2. Add repository GPG key
  mkdir -p /etc/apt/keyrings
  curl -fsSL https://aceofsnakes.github.io/aceofsnakes.gpg | gpg --dearmor -o /etc/apt/keyrings/aceofsnakes.gpg
  
  # 3. Register the sources stream listing
  echo "deb [signed-by=/etc/apt/keyrings/aceofsnakes.gpg] https://aceofsnakes.github.io/apt stable main" | tee /etc/apt/sources.list.d/aceofsnakes.list
  
  # 4. Pull signed database manifests
  apt-get update
  
  # 5. Check if your custom packages show up under cache policies
  echo "=== Available Target Packages ==="
  apt-cache policy netrc avrpioremote avrpioremote-qt5
'
