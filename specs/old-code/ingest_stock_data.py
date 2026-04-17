import os
import sys
import glob
import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

def get_db_connection():
    """Establishes a connection to the PostgreSQL database."""
    db_user = os.getenv("DB_USER")
    db_password = os.getenv("DB_PASSWORD")
    db_host = os.getenv("DB_HOST", "localhost")
    db_port = os.getenv("DB_PORT", "5432")
    db_name = os.getenv("DB_NAME")

    if not all([db_user, db_password, db_name]):
        print("Error: Missing database credentials in environment variables.")
        sys.exit(1)

    connection_string = f"postgresql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}"
    try:
        engine = create_engine(connection_string)
        return engine
    except Exception as e:
        print(f"Error connecting to database: {e}")
        sys.exit(1)

def process_files(directory=".", dry_run=False):
    """Scans directory for CSV files and ingests them into the database."""
    if not dry_run:
        engine = get_db_connection()
    else:
        print("Dry run mode: Database connection skipped.")
        engine = None
    
    # Pattern to match [stock_symbol]_[timeframe].csv
    # We'll just look for all CSVs and parse the name
    csv_files = glob.glob(os.path.join(directory, "*.csv"))

    if not csv_files:
        print(f"No CSV files found in {directory}")
        return

    print(f"Found {len(csv_files)} CSV files to process.")

    for file_path in csv_files:
        filename = os.path.basename(file_path)
        
        # Skip files that don't match the expected pattern roughly
        if '_' not in filename:
            print(f"Skipping {filename}: Does not match pattern [symbol]_[timeframe].csv")
            continue

        try:
            # Extract symbol and timeframe
            # Assuming format: S YMBOL_TIMEFRAME.csv
            # We use rsplit to split from the right, ensuring we capture the last part as timeframe
            name_part, ext = os.path.splitext(filename)
            parts = name_part.rsplit('_', 1)
            
            if len(parts) != 2:
                 print(f"Skipping {filename}: Could not extract symbol and timeframe.")
                 continue
                 
            symbol = parts[0]
            timeframe = parts[1]

            print(f"Processing {filename} -> Symbol: {symbol}, Timeframe: {timeframe}")

            # Read CSV
            df = pd.read_csv(file_path)

            # Insert 'timeframe' as the first column
            df.insert(0, 'timeframe', timeframe)

            if dry_run:
                print(f"[Dry Run] Would insert {len(df)} rows into table '{symbol.lower()}'")
                print(f"[Dry Run] Head of dataframe:\n{df.head()}")
                continue

            # Store in DB
            # Table name is the stock symbol
            table_name = symbol.lower() # Good practice to use lowercase for table names
            
            df.to_sql(table_name, engine, if_exists='append', index=False)
            print(f"Successfully ingested {filename} into table '{table_name}'")

        except Exception as e:
            print(f"Error processing {filename}: {e}")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description="Ingest stock CSV data into PostgreSQL.")
    parser.add_argument("directory", nargs="?", default=".", help="Directory containing CSV files")
    parser.add_argument("--dry-run", action="store_true", help="Run without connecting to the database")
    args = parser.parse_args()
    
    process_files(args.directory, dry_run=args.dry_run)
