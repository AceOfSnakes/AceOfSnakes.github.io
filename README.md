# Ace Of Snakes Package Repository

![Profile Avatar](https://github.com/AceOfSnakes.png)

Welcome to my custom package repository site! This site is configured to be served via **GitHub Pages** using a Jekyll theme interface.

## 📦 Repositories Hosted
* **APT (Debian/Ubuntu):** Custom builds and application utilities.
* **RPM (RHEL/Fedora):** RedHat-compatible package trees.

## 🚀 Quick Start Configuration
To utilize these packages on your local Linux system, ensure you import the repository configurations.

### 1. Add APT Repository
```bash
# Download and install the repository key
curl -sS https://YOUR_GITHUB_USERNAME.github.io/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/my-repo-archive-keyring.gpg

# Add the repository source list
echo "deb [signed-by=/usr/share/keyrings/my-repo-archive-keyring.gpg] https://YOUR_GITHUB_USERNAME.github.io/apt stable main" | sudo tee /etc/apt/sources.list.d/my-repo.list

# Update system listings
sudo apt update
```

### 2. Add RPM Repository
```bash
# Add the repository definition file
sudo dnf config-manager --add-repo https://YOUR_GITHUB_USERNAME.github.io/rpm/my-repo.repo

# Update package listings
sudo dnf check-update
```

---

## 🛠️ GitHub Pages Theme Deployment Instructions
To activate the **GitHub Pages template layout** natively using this Markdown file:

1. Create a file named `_config.yml` in the root of your repository.
2. Paste the following configuration content inside it:
   ```yaml
   theme: jekyll-theme-minimal
   title: My Package Repository
   description: Custom APT and RPM updates for Linux applications.
   ```
3. Commit both files into your `username.github.io` repository and remove any legacy standalone `index.html` file that could conflict with the automated build process.
