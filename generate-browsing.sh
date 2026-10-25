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

    # Start writing HTML template
    cat <<EOF > "${target_dir}/index.html"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} | Archive</title>
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif; background-color: #0d1117; color: #c9d1d9; padding: 40px 20px; margin: 0; line-height: 1.6; }
        .container { max-width: 800px; margin: 0 auto; background: #161b22; border: 1px solid #30363d; border-radius: 6px; padding: 30px; box-shadow: 0 4px 10px rgba(0,0,0,0.3); }
        h1 { font-size: 24px; color: #58a6ff; border-bottom: 1px solid #30363d; padding-bottom: 10px; margin-top: 0; }
        .back-link { display: inline-block; margin-bottom: 20px; color: #8b949e; text-decoration: none; font-size: 14px; }
        .back-link:hover { color: #58a6ff; }
        .file-list { list-style: none; padding: 0; margin: 0; }
        .file-item { display: flex; justify-content: space-between; align-items: center; padding: 10px 0; border-bottom: 1px solid #21262d; }
        .file-item:last-child { border-bottom: none; }
        .file-name { color: #58a6ff; text-decoration: none; font-weight: 500; font-family: monospace; word-break: break-all; }
        .file-name:hover { text-decoration: underline; }
        .file-size { color: #8b949e; font-size: 14px; font-family: monospace; }
        .empty-msg { color: #8b949e; font-style: italic; }
    </style>
</head>
<body>
    <div class="container">
        <a class="back-link" href="${parent_path}">← Back</a>
        <h1>${title}</h1>
        <ul class="file-list">
EOF

    # Populate directory matching patterns dynamically
    local count=0
    for filepath in ${target_dir}/${file_pattern}; do
        if [ -e "${filepath}" ] && [ "$(basename "${filepath}")" != "index.html" ]; then
            filename=$(basename "${filepath}")
            filesize=$(du -sh "${filepath}" | awk '{print $1}')
            echo "            <li class=\"file-item\"><a class=\"file-name\" href=\"${filename}\">${filename}</a><span class=\"file-size\">${filesize}</span></li>" >> "${target_dir}/index.html"
            count=$((count+1))
        fi
    done

    if [ $count -eq 0 ]; then
        echo "            <li class=\"empty-msg\">No packages found in this directory.</li>" >> "${target_dir}/index.html"
    fi

    # Close HTML layout blocks
    cat <<EOF >> "${target_dir}/index.html"
        </ul>
    </div>
</body>
</html>
EOF
}

# Execute page configurations
generate_html "apt/pool/main" "APT Package Pool" "${SITE_URL}/" "*.deb"
generate_html "rpm" "RPM Package Pool" "${SITE_URL}/" "*.rpm"

echo "Directory browser pages created successfully!"
