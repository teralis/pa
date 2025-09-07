# Customer Assets CDN

This repository serves customer assets (images, documents, etc.) via jsDelivr CDN for quick deployment without dev time.

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
    └── docs/
```

## Usage

1. Add customer assets to appropriate folder
2. Push to GitHub
3. Access via jsDelivr: `https://cdn.jsdelivr.net/gh/username/repo/customers/customer1/images/logo.png`

## Quick Commands

- Add new customer: `./scripts/add-customer.sh "customer-name"`
- Generate folder listing: `./scripts/generate-index.sh "customer-name"`