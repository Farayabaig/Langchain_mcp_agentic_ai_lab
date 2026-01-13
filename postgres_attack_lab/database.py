"""
Database connection and initialization utilities for Postgres MCP Attack Lab.
"""
import os
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
from contextlib import contextmanager


def get_db_config():
    """Get database configuration from environment variables."""
    return {
        'host': os.getenv('POSTGRES_HOST', 'localhost'),
        'database': os.getenv('POSTGRES_DB', 'attack_lab'),
        'user': os.getenv('POSTGRES_USER', 'postgres'),
        'password': os.getenv('POSTGRES_PASSWORD', 'postgres'),
        'port': os.getenv('POSTGRES_PORT', '5432')
    }


@contextmanager
def get_db_connection():
    """Context manager for database connections."""
    config = get_db_config()
    conn = None
    try:
        conn = psycopg2.connect(**config)
        yield conn
    except psycopg2.Error as e:
        print(f"Database error: {e}")
        raise
    finally:
        if conn:
            conn.close()


def verify_database():
    """Verify database connection and that tables exist."""
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT table_name 
                FROM information_schema.tables 
                WHERE table_schema = 'public'
                AND table_name IN ('sales', 'customers', 'users', 'api_credentials')
                ORDER BY table_name;
            """)
            tables = cursor.fetchall()
            cursor.close()
            return len(tables) == 4
    except Exception as e:
        print(f"Database verification failed: {e}")
        return False


def get_sample_query_result():
    """Get a sample query result to verify database is working."""
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT COUNT(*) FROM sales;")
            count = cursor.fetchone()[0]
            cursor.close()
            return count
    except Exception as e:
        print(f"Sample query failed: {e}")
        return None

