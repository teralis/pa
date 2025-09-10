# Asset CDN - Usage Guide

## 🚀 Super Simple Workflow

1. **Add files:** Drop anything into `assets/` folder
2. **Deploy:** `git add . && git commit -m "Add assets" && git push`
3. **Deploy Powershell** `git add . ; git commit -m "Add assets" ; git push`
4. **Share:** `https://cdn.jsdelivr.net/gh/teralis/pa/assets/filename.ext`

## 🔗 URL Format

```
https://cdn.jsdelivr.net/gh/teralis/pa/assets/[path/to/file]
```

## 📁 Examples

**Files you add:**
```
assets/
├── logo.png
├── client-docs/contract.pdf
├── qr-codes/menu.png
└── misc/anything.jpg
```

**URLs you get:**
- https://cdn.jsdelivr.net/gh/teralis/pa/assets/logo.png
- https://cdn.jsdelivr.net/gh/teralis/pa/assets/client-docs/contract.pdf  
- https://cdn.jsdelivr.net/gh/teralis/pa/assets/qr-codes/menu.png
- https://cdn.jsdelivr.net/gh/teralis/pa/assets/misc/anything.jpg

**Browse:** https://cdn.jsdelivr.net/gh/teralis/pa/assets/

## 🎯 Perfect for QR Codes

Upload image → Get instant CDN URL → Use in QR code generator

**No dev time lost, maximum flexibility!** ⚡