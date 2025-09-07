#!/bin/bash

# Add new customer script
# Usage: ./scripts/add-customer.sh "customer-name"

if [ -z "$1" ]; then
    echo "Usage: $0 <customer-name>"
    echo "Example: $0 \"acme-corp\""
    exit 1
fi

CUSTOMER_NAME="$1"
CUSTOMER_DIR="customers/$CUSTOMER_NAME"

echo "Creating customer directory structure for: $CUSTOMER_NAME"

# Create directories
mkdir -p "$CUSTOMER_DIR/images"
mkdir -p "$CUSTOMER_DIR/docs"

# Create placeholder files
echo "# $CUSTOMER_NAME Assets" > "$CUSTOMER_DIR/README.md"
echo "Upload your images here" > "$CUSTOMER_DIR/images/.gitkeep"
echo "Upload your documents here" > "$CUSTOMER_DIR/docs/.gitkeep"

echo "✅ Customer structure created at: $CUSTOMER_DIR"
echo "📂 Upload files to:"
echo "   - Images: $CUSTOMER_DIR/images/"
echo "   - Documents: $CUSTOMER_DIR/docs/"
echo ""
echo "🔗 CDN URLs will be:"
echo "   - https://cdn.jsdelivr.net/gh/USERNAME/REPO/$CUSTOMER_DIR/images/filename.ext"
echo "   - https://cdn.jsdelivr.net/gh/USERNAME/REPO/$CUSTOMER_DIR/docs/filename.ext"