#!/usr/bin/env bash
set -e

# Configuration
SITE_URL="https://aceofsnakes.github.io"

generate_html() {
    local target_dir="$1"
    local title="$2"
    local parent_path="$3"
    local file_pattern="$4"

    echo "Generating index for: ${target_dir}"
    mkdir -p "${target_dir}"
    
cat << 'EOF' > "${target_dir}/CONTENT.md"
| File | Size | SHA-256 |
| :--- | ---: | :--- |
EOF
echo "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;" >> "${target_dir}/CONTENT.md"
local count=0

# Quote the directory path, leave the glob pattern unquoted so it expands
for filepath in "${target_dir}"/${file_pattern}; do

    # Extract filename using fast built-in parameter expansion
    filename="${filepath##*/}"
    echo "$filename"    
    # Skip index.html and CONTENT.md itself
    if [[ "${filename}" == "index.html" || "${filename}" == "CONTENT.md" ]]; then
        continue
    fi

    # Get human-readable file size
    filesize=$(du -sh "${filepath}" | cut -f1)

    # Calculate SHA-256 hash (cross-platform: Linux and macOS)
    if command -v sha256sum >/dev/null 2>&1; then
        filesha=$(sha256sum "${filepath}" | cut -d' ' -f1)
    else
        filesha=$(shasum -a 256 "${filepath}" | cut -d' ' -f1)
    fi

    # Escape pipe characters in filenames to keep the Markdown table intact
    safe_filename="${filename//|/\\|}"

    echo "| [${safe_filename}](${filename}) | ${filesize} | \`${filesha}\` |" >> "${target_dir}/CONTENT.md"

done
}
# Execute page configurations
generate_html "apt/pool/main" "DEB Package Pool" "${SITE_URL}/" "*.deb"
generate_html "rpm" "RPM Package Pool" "${SITE_URL}/" "*.rpm"

echo "Directory browser pages created successfully!"
