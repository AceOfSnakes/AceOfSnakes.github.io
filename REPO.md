<html>
<body>
    <div class="repo-container">
        <!-- Header Section with your Profile Image -->
        <header class="profile-header">
            <div class="avatar-frame">
                <img src="https://github.com/aceofsnakes.png" alt="Profile Avatar">
            </div>
            <div>
                <h1 class="f1-light mb-1">Ace Of Snakes</h1>
                <p class="f4 color-fg-muted">Custom Linux DEB & RPM Package Repository</p>
            </div>
        </header>

        <!-- Main Layout Split: Content on Left, Meta on Right -->
        <div class="Layout Layout--sidebarPosition-right Layout--sidebar-narrow">

            <!-- Left Side: Installation Instructions -->
            <div class="Layout-main">

                <!-- APT Repository Block -->
                <div class="Box Box--condensed mb-4">
                    <div class="Box-header">
                        <h3 class="Box-title">Debian / Ubuntu (APT) Installation</h3>
                        <button class="btn btn-sm btn-octicon" type="button" aria-label="Copy APT commands"
                            onclick="copyToClipboard('apt-code', this)">
                            <svg class="octicon octicon-copy" viewBox="0 0 16 16" version="1.1" width="16" height="16"
                                aria-hidden="true">
                                <path
                                    d="M0 6.75C0 5.784.784 5 1.75 5h1.5a.75.75 0 0 1 0 1.5h-1.5a.25.25 0 0 0-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 0 0 .25-.25v-1.5a.75.75 0 0 1 1.5 0v1.5A1.75 1.75 0 0 1 9.25 16h-7.5A1.75 1.75 0 0 1 0 14.25Z">
                                </path>
                                <path
                                    d="M5 1.75C5 .784 5.784 0 6.75 0h7.5C15.216 0 16 .784 16 1.75v7.5A1.75 1.75 0 0 1 14.25 11h-7.5A1.75 1.75 0 0 1 5 9.25Zm1.75-.25a.25.25 0 0 0-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 0 0 .25-.25v-7.5a.25.25 0 0 0-.25-.25Z">
                                </path>
                            </svg>
                        </button>
                    </div>
                    <div class="Box-body">
                        <p class="f5 mb-2">Add the repository GPG key and register the source line:</p>
                        <pre class="color-bg-subtle p-3 border rounded-2 f6 ws-pre-wrap"><code id="apt-code">curl -fsSL https://aceofsnakes.github.io/aceofsnakes.gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/aceofsnakes.gpg
sudo tee /etc/apt/sources.list.d/aceofsnakes.sources &lt;&lt;EOF
X-Repolib-Name: Ace Of Snakes Repository
Types: deb
URIs: https://aceofsnakes.github.io/apt/
Suites: stable
Components: main
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/aceofsnakes.gpg
EOF

sudo apt update</code></pre>
                    </div>
                </div>

                <!-- DNF Repository Block -->
                <div class="Box Box--condensed mb-4">
                    <div class="Box-header">
                        <h3 class="Box-title">RHEL / Fedora / Rocky Linux (DNF) Installation</h3>
                        <button class="btn btn-sm btn-octicon" type="button" aria-label="Copy DNF commands"
                            onclick="copyToClipboard('dnf-code', this)">
                            <svg class="octicon octicon-copy" viewBox="0 0 16 16" version="1.1" width="16" height="16"
                                aria-hidden="true">
                                <path
                                    d="M0 6.75C0 5.784.784 5 1.75 5h1.5a.75.75 0 0 1 0 1.5h-1.5a.25.25 0 0 0-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 0 0 .25-.25v-1.5a.75.75 0 0 1 1.5 0v1.5A1.75 1.75 0 0 1 9.25 16h-7.5A1.75 1.75 0 0 1 0 14.25Z">
                                </path>
                                <path
                                    d="M5 1.75C5 .784 5.784 0 6.75 0h7.5C15.216 0 16 .784 16 1.75v7.5A1.75 1.75 0 0 1 14.25 11h-7.5A1.75 1.75 0 0 1 5 9.25Zm1.75-.25a.25.25 0 0 0-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 0 0 .25-.25v-7.5a.25.25 0 0 0-.25-.25Z">
                                </path>
                            </svg>
                        </button>
                    </div>
                    <div class="Box-body">
                        <p class="f5 mb-2">Create a repository configuration file under <code>/etc/dnf.repos.d/</code>:
                        </p>
                        <pre class="color-bg-subtle p-3 border rounded-2 f6 ws-pre-wrap"><code id="dnf-code">sudo tee /etc/yum.repos.d/aceofsnakes.repo &lt;&lt;EOF
[aceofsnakes]
name=Ace Of Snakes Repository \$basearch
baseurl=https://aceofsnakes.github.io/rpm/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://aceofsnakes.github.io/rpm/repomd.qg.key
includepkgs=*.\$basearch,*.noarch
EOF

sudo dnf check-update</code></pre>
                    </div>
                </div>

                <!-- Zypper Repository Block -->
                <div class="Box Box--condensed">
                    <div class="Box-header">
                        <h3 class="Box-title">openSUSE / SLES (Zypper) Installation</h3>
                        <button class="btn btn-sm btn-octicon" type="button" aria-label="Copy Zypper commands"
                            onclick="copyToClipboard('zypper-code', this)">
                            <svg class="octicon octicon-copy" viewBox="0 0 16 16" version="1.1" width="16" height="16"
                                aria-hidden="true">
                                <path
                                    d="M0 6.75C0 5.784.784 5 1.75 5h1.5a.75.75 0 0 1 0 1.5h-1.5a.25.25 0 0 0-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 0 0 .25-.25v-1.5a.75.75 0 0 1 1.5 0v1.5A1.75 1.75 0 0 1 9.25 16h-7.5A1.75 1.75 0 0 1 0 14.25Z">
                                </path>
                                <path
                                    d="M5 1.75C5 .784 5.784 0 6.75 0h7.5C15.216 0 16 .784 16 1.75v7.5A1.75 1.75 0 0 1 14.25 11h-7.5A1.75 1.75 0 0 1 5 9.25Zm1.75-.25a.25.25 0 0 0-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 0 0 .25-.25v-7.5a.25.25 0 0 0-.25-.25Z">
                                </path>
                            </svg>
                        </button>
                    </div>
                    <div class="Box-body">
                        <p class="f5 mb-2">Create a repository configuration file under <code>/etc/zypp/repos.d/</code>:
                        </p>
                        <pre class="color-bg-subtle p-3 border rounded-2 f6 ws-pre-wrap"><code id="zypper-code">sudo tee /etc/zypp/repos.d/aceofsnakes.repo &lt;&lt;EOF
[aceofsnakes]
name=Ace Of Snakes Repository
baseurl=https://aceofsnakes.github.io/rpm/
type=rpm-md
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://aceofsnakes.github.io/rpm/repomd.qg.key
EOF

sudo zypper refresh</code></pre>
                    </div>
                </div>

            </div>

            <!-- Right Side: Sidebar Metadata Card -->
            <div class="Layout-sidebar">
                <div class="Box p-3">
                    <h4 class="f5 mb-2">Repository Info</h4>
                    <ul class="list-style-none f6 color-fg-muted">
                        <li class="mb-2"><strong>Status:</strong> <span class="Label Label--success">Active</span></li>
                        <li class="mb-2"><strong>Host:</strong> GitHub Pages</li>
                        <li class="mb-3"><strong>Arch:</strong> x86_64, amd64, aarch64, arm64</li>

                        <!-- Packages Section: One package per line -->
                        <li class="border-top pt-2">
                            <strong>Packages:</strong>
                            <ul class="pl-3 mt-1 list-style-none" style="line-height: 1.6;">
                                <li class="text-mono color-fg-muted">avrpioremote</li>
                                <li class="text-mono color-fg-muted">avrpioremote-qt5</li>
                                <li class="text-mono color-fg-muted">netrc</li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Floating Footer -->
            <div class="floating-footer">
                <div class="footer-content">
                    <span>© 2026 Ace Of Snakes</span>
                    <div class="footer-links">
                        <a href="https://aceofsnakes.github.io/apt/pool/main">Browse DEB Packages</a>
                        <a href="https://aceofsnakes.github.io/rpm/">Browse RPM Packages</a>
                    </div>
                </div>
            </div>
</body>

</html>