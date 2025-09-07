#!/bin/bash

# Generate index.html for customer folder
# Usage: ./scripts/generate-index.sh "customer-name"

if [ -z "$1" ]; then
    echo "Usage: $0 <customer-name>"
    echo "Example: $0 \"acme-corp\""
    exit 1
fi

CUSTOMER_NAME="$1"
CUSTOMER_DIR="customers/$CUSTOMER_NAME"
INDEX_FILE="$CUSTOMER_DIR/index.html"

if [ ! -d "$CUSTOMER_DIR" ]; then
    echo "Error: Customer directory '$CUSTOMER_DIR' does not exist"
    echo "Run: $0 add-customer.sh \"$CUSTOMER_NAME\" first"
    exit 1
fi

echo "Generating index.html for: $CUSTOMER_NAME"

cat > "$INDEX_FILE" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$CUSTOMER_NAME - Assets</title>
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; }
        .header { border-bottom: 1px solid #eee; padding-bottom: 20px; margin-bottom: 30px; }
        .section { margin-bottom: 30px; }
        .file-list { list-style: none; padding: 0; }
        .file-list li { padding: 8px 0; border-bottom: 1px solid #f0f0f0; }
        .file-list a { text-decoration: none; color: #0066cc; }
        .file-list a:hover { text-decoration: underline; }
        .file-size { color: #666; font-size: 0.9em; margin-left: 10px; }
        .cdn-url { background: #f5f5f5; padding: 10px; border-radius: 4px; font-family: monospace; font-size: 0.9em; word-break: break-all; }
    </style>
</head>
<body>
    <div class="header">
        <h1>$CUSTOMER_NAME Assets</h1>
        <p>Quick access to your hosted files via CDN</p>
    </div>

    <div class="section">
        <h2>📁 Images</h2>
        <ul class="file-list" id="images-list">
EOF

# List image files
if [ -d "$CUSTOMER_DIR/images" ]; then
    find "$CUSTOMER_DIR/images" -type f ! -name '.gitkeep' | while read -r file; do
        filename=$(basename "$file")
        echo "            <li><a href=\"https://cdn.jsdelivr.net/gh/USERNAME/REPO/$CUSTOMER_DIR/images/$filename\" target=\"_blank\">$filename</a></li>" >> "$INDEX_FILE"
    done
fi

cat >> "$INDEX_FILE" << EOF
        </ul>
        <div class="cdn-url">
            <strong>CDN Pattern:</strong><br>
            https://cdn.jsdelivr.net/gh/USERNAME/REPO/$CUSTOMER_DIR/images/filename.ext
        </div>
    </div>

    <div class="section">
        <h2>📄 Documents</h2>
        <ul class="file-list" id="docs-list">
EOF

# List document files
if [ -d "$CUSTOMER_DIR/docs" ]; then
    find "$CUSTOMER_DIR/docs" -type f ! -name '.gitkeep' | while read -r file; do
        filename=$(basename "$file")
        echo "            <li><a href=\"https://cdn.jsdelivr.net/gh/USERNAME/REPO/$CUSTOMER_DIR/docs/$filename\" target=\"_blank\">$filename</a></li>" >> "$INDEX_FILE"
    done
fi

cat >> "$INDEX_FILE" << EOF
        </ul>
        <div class="cdn-url">
            <strong>CDN Pattern:</strong><br>
            https://cdn.jsdelivr.net/gh/USERNAME/REPO/$CUSTOMER_DIR/docs/filename.ext
        </div>
    </div>

    <div class="section">
        <h2>ℹ️ How to Use</h2>
        <ol>
            <li>Right-click any file link above and copy the URL</li>
            <li>Use these URLs directly in your applications</li>
            <li>Files are cached globally via jsDelivr CDN</li>
            <li>Updates may take a few minutes to propagate</li>
        </ol>
    </div>
</body>
</html>
EOF

echo "✅ Generated: $INDEX_FILE"
echo "🔗 Access at: https://cdn.jsdelivr.net/gh/USERNAME/REPO/$INDEX_FILE"