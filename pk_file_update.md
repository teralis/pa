# PK File Update Guide

## Update Workflow

### 1. Commit and Push Changes (PowerShell)

**For all files in pk folder:**
```powershell
git add pk/*
git commit -m "Update PK files - $(Get-Date -Format 'yyyy-MM-dd')"
git push
```

**For specific file (Hyperlinked Spec.pdf):**
```powershell
git add "pk/Hyperlinked Spec.pdf"
git commit -m "Update Hyperlinked Spec.pdf - $(Get-Date -Format 'yyyy-MM-dd')"
git push
```

### 2. Purge CDN Cache

1. Visit: https://www.jsdelivr.com/tools/purge
2. Enter URL: `https://cdn.jsdelivr.net/gh/teralis/pa/pk/Hyperlinked Spec.pdf`
3. Click "Purge"
4. File updates immediately

---

**Note:** Without purging, CDN cache expires after 7 days.
