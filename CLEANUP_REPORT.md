# Cleaned repo reconstruction

This repo was reconstructed from:
- backend.zip
- frontend.zip
- codebase_patch_audit_auth_permissions.zip

Applied cleanup:
- removed duplicate suffixed files like `App (2).tsx`, `ExchangeSchema (5).java`
- overwrote known-broken files with patched versions
- preserved existing project layout as `backend/` and `frontend/`

Removed duplicate files (15):
- `backend/src/main/java/com/rathore/stockanalysis/common/exchange/ExchangeSchema (2).java`
- `backend/src/main/java/com/rathore/stockanalysis/common/exchange/ExchangeSchema (3).java`
- `backend/src/main/java/com/rathore/stockanalysis/common/exchange/ExchangeSchema (4).java`
- `backend/src/main/java/com/rathore/stockanalysis/common/exchange/ExchangeSchema (5).java`
- `backend/src/main/java/com/rathore/stockanalysis/common/exchange/ExchangeSchemaRegistry (2).java`
- `backend/src/main/java/com/rathore/stockanalysis/common/exchange/ExchangeSchemaRegistry (3).java`
- `backend/src/main/java/com/rathore/stockanalysis/common/exchange/ExchangeSchemaRegistry (4).java`
- `backend/src/main/java/com/rathore/stockanalysis/common/exchange/ExchangeSchemaRegistry (5).java`
- `backend/src/main/resources/application (2).yml`
- `backend/src/main/resources/application-local (2).yml`
- `frontend/src/instruments/InstrumentsPage (2).tsx`
- `frontend/src/instruments/InstrumentsPage (3).tsx`
- `frontend/src/routes/App (2).tsx`
- `frontend/src/routes/App (3).tsx`
- `frontend/src/routes/App (4).tsx`
