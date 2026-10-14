# Ace Of Snakes Package Repository

![Profile Avatar](https://github.com/AceOfSnakes.png)

Welcome to my custom package repository site! This site is configured to be served via **GitHub Pages** using a Jekyll theme interface.

## Repositories Hosted
* **APT (Debian/Ubuntu):** Custom builds and application utilities.
* **RPM (RHEL/Fedora):** RedHat-compatible package trees.

## Quick Start Configuration
To utilize these packages on your local Linux system, ensure you import the repository configurations.

### 1. Add APT Repository
```bash
# Download and install the repository key
curl -sS https://aceofsnakes.github.io/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/aceofsnakes.gpg

# Add the repository source list
echo "deb [signed-by=/usr/share/keyrings/aceofsnakes.gpg] https://aceofsnakes.github.io/apt stable main" | sudo tee /etc/apt/sources.list.d/my-repo.list

# Update system listings
sudo apt update
```

### 2. Add RPM Repository
```bash
# Add the repository definition file
sudo dnf config-manager --add-repo https://aceofsnakes.github.io/rpm/aceofsnakes.repo

# Update package listings
sudo dnf check-update
```


