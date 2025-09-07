#!/bin/bash

# CDN Catalog Refresh Script
# Automatically scans repository and generates CDN_CATALOG.md

BASE_URL="https://cdn.jsdelivr.net/gh/teralis/pa"
CATALOG_FILE="CDN_CATALOG.md"
CURRENT_DATE=$(date +"%Y-%m-%d")

echo "🔄 Refreshing CDN Catalog..."

# Start building the catalog
cat > "$CATALOG_FILE" << EOF
# CDN URL Catalog

**Base URL:** \`$BASE_URL/\`

Last updated: $CURRENT_DATE

---

## 📁 Browse Directories

- **Root:** $BASE_URL/
- **Assets (Tabler Icons):** $BASE_URL/assets/
- **QRTub Project:** $BASE_URL/qrtub/

---

## 🎯 QRTub Project Files

EOF

# Scan qrtub directory
if [ -d "qrtub" ]; then
    echo "### Shared Icons" >> "$CATALOG_FILE"
    if [ -d "qrtub/_shared/icons" ]; then
        find qrtub/_shared/icons -type f | sort | while read -r file; do
            filename=$(basename "$file")
            extension="${filename##*.}"
            size=""
            if [ "$extension" = "png" ] || [ "$extension" = "jpg" ] || [ "$extension" = "jpeg" ]; then
                # Try to get image dimensions if possible
                size_info=$(file "$file" 2>/dev/null | grep -o '[0-9]*x[0-9]*' | head -1)
                if [ -n "$size_info" ]; then
                    size=" ($size_info)"
                fi
            fi
            echo "- **$filename**$size: $BASE_URL/$file" >> "$CATALOG_FILE"
        done
    fi
    
    echo "" >> "$CATALOG_FILE"
    echo "### Project Files" >> "$CATALOG_FILE"
    find qrtub -maxdepth 1 -type f | sort | while read -r file; do
        filename=$(basename "$file")
        echo "- **$filename**: $BASE_URL/$file" >> "$CATALOG_FILE"
    done
fi

# Check if Tabler icons exist and add section if they do
if [ -d "assets/icons_tabler" ]; then
    cat >> "$CATALOG_FILE" << EOF

---

## 📦 Tabler Icons Library

### Browse Icons
- **All Icons:** $BASE_URL/assets/icons_tabler/
EOF

    if [ -d "assets/icons_tabler/outline" ]; then
        echo "- **Outline Icons:** $BASE_URL/assets/icons_tabler/outline/" >> "$CATALOG_FILE"
    fi
    
    if [ -d "assets/icons_tabler/filled" ]; then
        echo "- **Filled Icons:** $BASE_URL/assets/icons_tabler/filled/" >> "$CATALOG_FILE"
    fi

    # Add popular icons only if they exist
    if [ -f "assets/icons_tabler/outline/qrcode.svg" ]; then
        cat >> "$CATALOG_FILE" << EOF

### Popular Icons for QR Apps

#### UI & Navigation
- **menu-2.svg**: $BASE_URL/assets/icons_tabler/outline/menu-2.svg
- **x.svg**: $BASE_URL/assets/icons_tabler/outline/x.svg
- **home.svg**: $BASE_URL/assets/icons_tabler/outline/home.svg
- **settings.svg**: $BASE_URL/assets/icons_tabler/outline/settings.svg

#### QR Code Related
- **qrcode.svg**: $BASE_URL/assets/icons_tabler/outline/qrcode.svg
- **camera.svg**: $BASE_URL/assets/icons_tabler/outline/camera.svg
- **scan.svg**: $BASE_URL/assets/icons_tabler/outline/scan.svg

#### Actions
- **download.svg**: $BASE_URL/assets/icons_tabler/outline/download.svg
- **share.svg**: $BASE_URL/assets/icons_tabler/outline/share.svg
- **copy.svg**: $BASE_URL/assets/icons_tabler/outline/copy.svg
EOF
    fi
fi

# Add other asset directories if they exist
if [ -d "assets" ]; then
    echo "" >> "$CATALOG_FILE"
    echo "---" >> "$CATALOG_FILE"
    echo "" >> "$CATALOG_FILE"
    echo "## 📁 Other Assets" >> "$CATALOG_FILE"
    find assets -type f | grep -v desktop.ini | sort | while read -r file; do
        filename=$(basename "$file")
        echo "- **$filename**: $BASE_URL/$file" >> "$CATALOG_FILE"
    done
fi

# Add any additional directories found
echo "### Additional Assets" >> "$CATALOG_FILE"
find . -maxdepth 2 -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.gif" -o -name "*.svg" -o -name "*.pdf" -o -name "*.css" -o -name "*.js" \) | grep -v assets/icons_tabler | grep -v qrtub | grep -v ".git" | sort | while read -r file; do
    # Clean up the path
    clean_path="${file#./}"
    filename=$(basename "$file")
    if [ "$clean_path" != "$CATALOG_FILE" ] && [ "$clean_path" != "refresh-catalog.sh" ]; then
        echo "- **$filename**: $BASE_URL/$clean_path" >> "$CATALOG_FILE"
    fi
done

cat >> "$CATALOG_FILE" << EOF

---

## 💡 Usage Examples

**HTML:**
\`\`\`html
<img src="$BASE_URL/assets/icons_tabler/outline/qrcode.svg" 
     width="24" height="24" alt="QR Code">
\`\`\`

**CSS:**
\`\`\`css
.icon-qr {
  background: url('$BASE_URL/assets/icons_tabler/outline/qrcode.svg') no-repeat center;
  background-size: contain;
  width: 24px;
  height: 24px;
}
\`\`\`

**React/Vue:**
\`\`\`jsx
<img src="$BASE_URL/qrtub/_shared/icons/weight.png" alt="Weight" />
\`\`\`

---

## 🔄 Cache Information

- **Cache Time:** 7 days (automatic)
- **Force Refresh:** Add \`?v=timestamp\` to URL
- **Purge Cache:** https://www.jsdelivr.com/tools/purge

---

*🤖 This catalog is auto-generated. Run \`./refresh-catalog.sh\` to update.*
EOF

echo "✅ CDN Catalog refreshed successfully!"
echo "📄 File: $CATALOG_FILE"
echo "📊 $(wc -l < "$CATALOG_FILE") lines generated"