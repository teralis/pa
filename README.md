# Customer Assets CDN

This repository serves customer assets (images, documents, etc.) via jsDelivr CDN for quick deployment without dev time.

## 🚀 Live URLs

- **Browse All Customers:** https://cdn.jsdelivr.net/gh/teralis/pa/customers/
- **Example Customer:** https://cdn.jsdelivr.net/gh/teralis/pa/customers/example-corp/
- **Direct File:** https://cdn.jsdelivr.net/gh/teralis/pa/customers/example-corp/images/banner.jpg

## Structure

```
customers/
├── customer1/
│   ├── images/
│   └── docs/
├── customer2/
│   ├── images/
│   └── docs/
└── example-corp/
    ├── images/
    ├── docs/
    └── README.md (file links)
```

## Usage

1. Add customer assets to appropriate folder
2. Push to GitHub
3. Access via jsDelivr: `https://cdn.jsdelivr.net/gh/teralis/pa/customers/customer1/images/logo.png`
4. Browse directories: `https://cdn.jsdelivr.net/gh/teralis/pa/customers/customer1/`

## Quick Commands

- Add new customer: `./scripts/add-customer.sh "customer-name"`
- Generate README with links: `./scripts/generate-index.sh "customer-name"`