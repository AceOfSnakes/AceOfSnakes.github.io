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

    # Populate directory matching patterns dynamically
    local count=0
    for filepath in ${target_dir}/${file_pattern}; do
        if [ -e "${filepath}" ] && [ "$(basename "${filepath}")" != "index.html" ]; then
            filename=$(basename "${filepath}")
            filesize=$(du -sh "${filepath}" | awk '{print $1}')
            echo "[${filename}](${filename})" >> "${target_dir}/CONTENT.md"
            count=$((count+1))
        fi
    done

    if [ $count -eq 0 ]; then
        echo "No packages found in this directory" >> "${target_dir}/CONTENT.md"
    fi
}

# Execute page configurations
generate_html "apt/pool/main" "DEB Package Pool" "${SITE_URL}/" "*.deb"
generate_html "rpm" "RPM Package Pool" "${SITE_URL}/" "*.rpm"

echo "Directory browser pages created successfully!"
