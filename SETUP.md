# Edu-Flow Project - Setup & Run Guide

## System Requirements
- **Node.js**: v24.13.0 or higher
- **pnpm**: v10.33.0 or higher
- **PostgreSQL**: Optional (can run with mock data as fallback)

## Quick Start (Windows)

### Option 1: Run with Mock Data (Recommended for Offline Testing)
```bash
.\run-mock.bat
```
This starts the project using mock API data without needing a database.

### Option 2: Run with Database
First, set up PostgreSQL and create a `.env.local` file in the project root:
```
DATABASE_URL=postgresql://user:password@localhost:5432/eduflow
```

Then run:
```bash
.\run.bat
```

---

## Services & Ports

| Service | Port | URL |
|---------|------|-----|
| Frontend | 5173 | http://localhost:5173 |
| API Server | 3000 | http://localhost:3000 |
| Health Check | 3000 | http://localhost:3000/api/healthz |

---

## Environment Variables

### Frontend (`artifacts/edu-platform`)
- `PORT=5173` - Frontend Vite dev server port
- `BASE_PATH=/` - Base URL path for assets

### API Server (`artifacts/api-server`)
- `PORT=3000` - API server port
- `NODE_ENV=development` - Default for dev
- `DATABASE_URL` - PostgreSQL connection string (optional, falls back to mock data)

### Example Database Setup (PostgreSQL)
```bash
# Create database
createdb eduflow

# Set DATABASE_URL
$env:DATABASE_URL = "postgresql://postgres:password@localhost:5432/eduflow"

# Run migrations
cd lib/db
pnpm run push
```

---

## Files Included

- **run.bat** - Full startup script (requires database)
- **run-mock.bat** - Mock data startup script (offline mode)
- **run.ps1** - PowerShell version
- **run.sh** - Linux/macOS version

---

## Troubleshooting

### Error: "PORT environment variable is required"
✓ Fixed - run-mock.bat sets default ports

### Error: "DATABASE_URL must be set"
✓ Fixed - run-mock.bat uses mock data, no database needed

### Error: "Unsafe attempt to load URL from {index}.js from frame"
✓ Fixed - Vite proxy configured correctly

### API returns empty data
- Check if API is running on http://localhost:3000
- Check browser console for errors
- Try run-mock.bat for fallback mock data

---

## Project Structure

```
Edu-Flow/
├── artifacts/
│   ├── api-server/          # Express.js API
│   ├── edu-platform/        # React frontend (Vite)
│   └── mockup-sandbox/      # UI mockups
├── lib/
│   ├── api-client-react/    # API client library
│   ├── api-spec/            # OpenAPI spec
│   ├── api-zod/             # Zod schemas
│   └── db/                  # Drizzle ORM database
└── scripts/                 # Utility scripts
```

---

## Development

### Install Dependencies
```bash
pnpm install
```

### Build Project
```bash
pnpm run build
```

### Type Check
```bash
pnpm run typecheck
```

### Start Frontend Only
```bash
cd artifacts/edu-platform
pnpm run dev
```

### Start API Only (with mock mode)
```bash
cd artifacts/api-server
set PORT=3000 && pnpm run dev-mock
```

---

**For questions or issues, check the console output for detailed error messages.**
