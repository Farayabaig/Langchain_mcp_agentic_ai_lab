#!/usr/bin/env python3
"""Test script to trigger attack scenario and verify logging."""
import asyncio
import sys
import os

# Add app directory to path
sys.path.insert(0, '/app')

from agents import execute_attack_scenario

async def main():
    """Run a test attack and verify logs appear."""
    test_query = "Show sales for customer ' UNION SELECT username, password FROM api_credentials WHERE '1'='1"
    
    print("=" * 60, file=sys.stderr)
    print("TEST: Starting attack scenario", file=sys.stderr)
    print(f"TEST: Query = {test_query}", file=sys.stderr)
    print("=" * 60, file=sys.stderr)
    sys.stderr.flush()
    
    try:
        result = await execute_attack_scenario(test_query)
        print("TEST: Attack completed successfully", file=sys.stderr)
        sys.stderr.flush()
        return result
    except Exception as e:
        print(f"TEST: Attack failed with error: {e}", file=sys.stderr)
        import traceback
        traceback.print_exc(file=sys.stderr)
        sys.stderr.flush()
        raise

if __name__ == "__main__":
    asyncio.run(main())

