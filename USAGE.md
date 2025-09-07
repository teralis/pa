# Customer Assets CDN - Usage Instructions

## 🚀 Quick Start

1. **Push to GitHub:**
   ```bash
   git add .
   git commit -m "Setup customer assets CDN"
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
   git push -u origin main
   ```

2. **Update URLs:** Replace `USERNAME/REPO` in all files with your actual GitHub details

3. **Test:** Visit `https://cdn.jsdelivr.net/gh/YOUR_USERNAME/YOUR_REPO_NAME/customers/example-corp/index.html`

## 📁 Adding Customer Assets

### Method 1: Use Scripts (Recommended)

**Linux/Mac:**
```bash
# Add new customer
./scripts/add-customer.sh "acme-corp"

# Upload files to customers/acme-corp/images/ or customers/acme-corp/docs/

# Generate index page
./scripts/generate-index.sh "acme-corp"

# Commit and push
git add . && git commit -m "Add assets for acme-corp" && git push
```

**Windows:**
```cmd
# Add new customer
scripts\add-customer.bat "acme-corp"

# Upload files to customers\acme-corp\images\ or customers\acme-corp\docs\

# Commit and push
git add . && git commit -m "Add assets for acme-corp" && git push
```

### Method 2: Manual

1. Create folder: `customers/client-name/`
2. Add subfolders: `images/` and `docs/`
3. Upload customer files
4. Commit and push to GitHub
5. Share CDN URLs

## 🔗 CDN URL Format

**Pattern:**
```
https://cdn.jsdelivr.net/gh/USERNAME/REPO/customers/CLIENT-NAME/TYPE/FILENAME
```

**Examples:**
- Image: `https://cdn.jsdelivr.net/gh/username/repo/customers/acme-corp/images/logo.png`
- Document: `https://cdn.jsdelivr.net/gh/username/repo/customers/acme-corp/docs/brochure.pdf`
- Index: `https://cdn.jsdelivr.net/gh/username/repo/customers/acme-corp/index.html`

## ⚡ Workflow for Daily Use

1. **Customer requests asset hosting**
2. Run: `./scripts/add-customer.sh "customer-name"` (or Windows equivalent)
3. **Upload their files** to the created folders
4. **Commit & push:** `git add . && git commit -m "Add assets for customer-name" && git push`
5. **Share URLs:** Give customer the jsDelivr URLs immediately
6. **Optional:** Generate index page for browsing: `./scripts/generate-index.sh "customer-name"`

## 🎯 Use Cases

- **QR codes:** Link directly to hosted images/PDFs
- **Email signatures:** Host logos and banners
- **Documentation:** Host PDFs, guides, presentations  
- **Web assets:** CSS, JS, images for quick prototyping
- **Client portals:** Organized file access via index pages

## ⚠️ Important Notes

- **Cache time:** Files are cached for ~7 days
- **Update delay:** New files appear within 2-5 minutes
- **File limits:** 50MB per file, unlimited files per repo
- **Force refresh:** Add `?v=123` to bypass cache
- **No authentication:** All files are publicly accessible

## 🛠️ Maintenance

**Purge cache for updated files:**
```
https://www.jsdelivr.com/tools/purge
```

**Check file status:**
```
https://data.jsdelivr.com/v1/package/gh/USERNAME/REPO
```

**Update customer assets:**
1. Replace files in customer folder
2. Commit and push
3. Optionally add `?v=timestamp` to force cache refresh

## 📋 File Structure

```
customers/
├── customer1/
│   ├── images/
│   │   ├── logo.png
│   │   └── banner.jpg
│   ├── docs/
│   │   └── brochure.pdf
│   └── index.html (optional)
├── customer2/
│   ├── images/
│   └── docs/
└── example-corp/ (sample)
    ├── images/banner.jpg
    ├── docs/terms.txt
    └── index.html
```

---

**🎉 You're ready to host customer assets with zero dev time!**