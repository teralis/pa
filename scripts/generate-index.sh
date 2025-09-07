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
README_FILE="$CUSTOMER_DIR/README.md"

if [ ! -d "$CUSTOMER_DIR" ]; then
    echo "Error: Customer directory '$CUSTOMER_DIR' does not exist"
    echo "Run: $0 add-customer.sh \"$CUSTOMER_NAME\" first"
    exit 1
fi

echo "Generating README.md for: $CUSTOMER_NAME"

cat > "$README_FILE" << EOF
# $CUSTOMER_NAME Assets

## 🔗 Direct File Links

### Images
EOF

# List image files
if [ -d "$CUSTOMER_DIR/images" ]; then
    find "$CUSTOMER_DIR/images" -type f ! -name '.gitkeep' | while read -r file; do
        filename=$(basename "$file")
        echo "- **$filename:** https://cdn.jsdelivr.net/gh/teralis/pa/$CUSTOMER_DIR/images/$filename" >> "$README_FILE"
    done
fi

cat >> "$README_FILE" << EOF

### Documents
EOF

# List document files
if [ -d "$CUSTOMER_DIR/docs" ]; then
    find "$CUSTOMER_DIR/docs" -type f ! -name '.gitkeep' | while read -r file; do
        filename=$(basename "$file")
        echo "- **$filename:** https://cdn.jsdelivr.net/gh/teralis/pa/$CUSTOMER_DIR/docs/$filename" >> "$README_FILE"
    done
fi

cat >> "$README_FILE" << EOF

## 📁 Browse All Files
- **Directory:** https://cdn.jsdelivr.net/gh/teralis/pa/$CUSTOMER_DIR/
- **Images Folder:** https://cdn.jsdelivr.net/gh/teralis/pa/$CUSTOMER_DIR/images/
- **Docs Folder:** https://cdn.jsdelivr.net/gh/teralis/pa/$CUSTOMER_DIR/docs/

## 💡 Usage
Copy any URL above and use directly in your applications, QR codes, or share with others.
EOF

echo "✅ Generated: $README_FILE"
echo "🔗 Browse directory at: https://cdn.jsdelivr.net/gh/teralis/pa/$CUSTOMER_DIR/"