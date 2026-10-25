#!/usr/bin/env bash
set -e

# Configuration
REPO_DIR="apt"
GPG_KEY="5F240D98C45F6AC7A1EBB0C670EFD6A74CBA5474"

echo "Generating Packages indexes..."
cd "$REPO_DIR"


# 1. Scan packages filtering by matching architecture
dpkg-scanpackages -a amd64 pool/main /dev/null > dists/stable/main/binary-amd64/Packages
gzip -c9 dists/stable/main/binary-amd64/Packages > dists/stable/main/binary-amd64/Packages.gz

dpkg-scanpackages -a arm64 pool/main /dev/null > dists/stable/main/binary-arm64/Packages
gzip -c9 dists/stable/main/binary-arm64/Packages > dists/stable/main/binary-arm64/Packages.gz

echo "Generating Release metadata..."
# 2. Create the base Release file template
cat <<EOF > dists/stable/Release
Origin: Ace Of Snakes
Label: Ace Of Snakes Repository
Suite: stable
Codename: stable
Architectures: amd64 arm64
Components: main
Description: Custom Linux APT Package Repository
Date: $(date -Ru)
EOF

# 3. Compute and append checksums for all index files
echo "SHA256:" >> dists/stable/Release
for file in $(find dists/stable -type f \( -name "Packages" -o -name "Packages.gz" \)); do
    # Remove 'dists/stable/' prefix from file paths for the manifest layout
    rel_path=${file#dists/stable/}
    sha256=$(sha256sum "$file" | awk '{print $1}')
    size=$(stat -c%s "$file")
    echo " $sha256 $size $rel_path" >> dists/stable/Release
done

echo "Cryptographically signing repository..."
# 4. Clear old signatures
rm -f dists/stable/Release.gpg dists/stable/InRelease

# 5. Generate detached and inline cryptographic signatures
gpg --batch --yes --digest-algo SHA256 --local-user "$GPG_KEY" --armor --detach-sign -o dists/stable/Release.gpg dists/stable/Release
gpg --batch --yes --digest-algo SHA256 --local-user "$GPG_KEY" --armor --clear-sign -o dists/stable/InRelease dists/stable/Release

echo "Exporting public key..."
gpg --armor --export "$GPG_KEY" > ../aceofsnakes.gpg

echo "Repository updated successfully!"
