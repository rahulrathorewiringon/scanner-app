# Stock Analysis Platform - Mock Database Testing

This setup provides an in-memory H2 database with realistic mock data for testing the API and frontend functionality without requiring a full PostgreSQL setup.

## Quick Start

### Prerequisites
- Java 21
- Maven
- Node.js + npm

### Run Everything
```bash
# Setup dependencies (first time only)
run-tests.bat setup

# Start both backend and frontend
run-tests.bat
```

### Run Individual Services
```bash
# Backend only
run-tests.bat backend

# Frontend only
run-tests.bat frontend
```

## Mock Data Included

### Instruments (NSE)
- RELIANCE, TCS, HDFC, INFY, ICICI, BAJAJ, KOTAK, LT, MARUTI, ITC
- All marked as active with chart data available

### Market Data
- **RELIANCE**: Complete daily candles for last 30 trading days (March-April 2026)
- **Technical Indicators**: SMA (5,10,20,50,100,200), ATR, range ratios, body/wick percentages
- **Pivot Analysis**: High/Low pivots with arm lengths and strengths
- Other instruments: Latest daily candle data

### User Data
- **Saved Screener**: "Large Cap Stocks" (> ₹1000 filter)
- **Watchlist**: "My Favorites" with RELIANCE and TCS
- **Alert Rule**: Price alert for RELIANCE above ₹2700
- **Workspace Preset**: Default layout configuration

## API Endpoints Available

### Dashboard
- `GET /api/analytics/dashboard-overview`
- `GET /api/analytics/data-coverage`

### Instruments
- `GET /api/instruments/{instrumentId}/summary`
- `POST /api/analytics/instruments/search`

### Charts
- `GET /api/instruments/{instrumentId}/charts`

### Screener
- `GET /api/screener/filter-metadata`
- `POST /api/screener/count`
- `POST /api/screener/run`
- `GET /api/screener/saved-definitions`

### Watchlists
- `GET /api/watchlists`
- `GET /api/watchlists/{watchlistId}`
- `GET /api/watchlists/{watchlistId}/items`

### Alerts
- `GET /api/alerts/rules`

## Testing Features

### Frontend Testing
- Dashboard with data coverage metrics
- Instrument search and summary pages
- Multi-timeframe charting with technical indicators
- Screener with saved definitions
- Watchlist management
- Alert configuration
- Workspace layout presets

### API Testing
- All REST endpoints return realistic data
- Proper error handling
- JSON responses matching production schema
- Pagination and filtering support

## Database Configuration

The test profile uses:
- **Database**: H2 in-memory
- **URL**: `jdbc:h2:mem:testdb`
- **Schema**: Auto-created from `schema.sql`
- **Data**: Pre-populated from `data.sql`

## File Structure

```
backend/src/main/resources/
├── application-test.yml    # Test profile config
├── schema.sql             # Database schema
└── data.sql               # Mock data

frontend/
├── .env                   # API base URL config
└── ...

run-tests.bat              # Main test runner
run-backend.bat            # Backend runner
run-frontend.bat           # Frontend runner
```

## Troubleshooting

### Backend Won't Start
- Ensure Java 21 is installed
- Check Maven is available
- Verify port 8080 is not in use

### Frontend Won't Start
- Run `run-tests.bat setup` first
- Ensure Node.js and npm are installed
- Check port 5173 is available

### API Calls Fail
- Ensure backend is running on port 8080
- Check browser console for CORS errors
- Verify VITE_API_BASE_URL in frontend/.env

### Database Issues
- H2 database is in-memory only (data lost on restart)
- Check backend logs for SQL errors
- Schema/data files are loaded automatically

## Development Notes

- Mock data represents April 2026 market conditions
- RELIANCE has the most complete dataset for charting
- All timestamps use realistic trading hours
- Technical indicators calculated with standard formulas
- User data uses test_user as the default user ID