#!/usr/bin/env bash
set -e

# Configuration
RPM_DIR="rpm"
GPG_KEY="4CBA5474"

# Dependencies Check
if ! command -v createrepo_c &> /dev/null && ! command -v createrepo &> /dev/null; then
    echo "Error: createrepo_c or createrepo is required. Install via: sudo apt install createrepo-c"
    exit 1
fi

echo "Signing individual RPM packages..."
# 1. Clear-sign all RPMs in the directory
rpm --addsign "$RPM_DIR"/*.rpm

echo "Generating RPM repository metadata..."
# 2. Build the repodata index files
if command -v createrepo_c &> /dev/null; then
    createrepo_c --update "$RPM_DIR/"
else
    createrepo "$RPM_DIR/"
fi

echo "Cryptographically signing repomd.xml..."
# 3. Clear old signature file
rm -f "$RPM_DIR/repodata/repomd.xml.asc"

# 4. Generate the detached signature for DNF security validation
gpg --batch --yes --digest-algo SHA256 --local-user "$GPG_KEY" --detach-sign --armor "$RPM_DIR/repodata/repomd.xml"

echo "Exporting public key for DNF consumers..."
gpg --armor --export "$GPG_KEY" > rpm/repomd.qg.key

echo "RPM Repository updated successfully!"
