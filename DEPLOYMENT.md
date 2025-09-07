# Deployment Guide

## Initial Setup

1. **Create GitHub Repository:**
   ```bash
   # Initialize and push to GitHub
   git add .
   git commit -m "Initial customer assets CDN setup"
   git remote add origin https://github.com/USERNAME/REPO.git
   git push -u origin main
   ```

2. **Update URLs in files:**
   Replace `USERNAME/REPO` in all files with your actual GitHub username and repository name:
   - README.md
   - templates/index-template.html
   - customers/*/index.html
   - Generated scripts output

## Testing CDN URLs

Once pushed to GitHub, test these URLs (replace USERNAME/REPO):

- **Test Image:** https://cdn.jsdelivr.net/gh/USERNAME/REPO/customers/example-corp/images/banner.jpg
- **Test Document:** https://cdn.jsdelivr.net/gh/USERNAME/REPO/customers/example-corp/docs/terms.txt
- **Test Index Page:** https://cdn.jsdelivr.net/gh/USERNAME/REPO/customers/example-corp/index.html

## Adding New Customers

### Option 1: Command Line
```bash
# Linux/Mac
./scripts/add-customer.sh "new-customer-name"

# Windows
scripts\add-customer.bat "new-customer-name"
```

### Option 2: Manual
1. Create `customers/new-customer-name/` directory
2. Add `images/` and `docs/` subdirectories
3. Upload customer files
4. Generate index.html using script or template

## Workflow

1. **Add files** → `customers/customer-name/images/` or `customers/customer-name/docs/`
2. **Commit & push** → `git add . && git commit -m "Add assets for customer-name" && git push`
3. **Share URLs** → `https://cdn.jsdelivr.net/gh/USERNAME/REPO/customers/customer-name/images/file.ext`

## Cache Management

- **Normal cache:** 7 days
- **Force update:** Add `?v=timestamp` to URL
- **Purge cache:** Use jsDelivr purge tool: `https://www.jsdelivr.com/tools/purge`