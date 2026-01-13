-- Postgres MCP Attack Lab Database Schema
-- Creates tables and seed data for demonstrating tool parameter injection

-- Sales table
CREATE TABLE IF NOT EXISTS sales (
    id SERIAL PRIMARY KEY,
    customer VARCHAR(100) NOT NULL,
    product VARCHAR(100) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    sale_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Customers table
CREATE TABLE IF NOT EXISTS customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    company VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100),
    role VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- API credentials table (sensitive data for attack demonstration)
CREATE TABLE IF NOT EXISTS api_credentials (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    service_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert test data

-- Sales data
INSERT INTO sales (customer, product, amount, sale_date) VALUES
    ('Acme Corp', 'Widget A', 5000.00, '2024-01-15'),
    ('Acme Corp', 'Widget B', 3000.00, '2024-01-20'),
    ('TechStart Inc', 'Widget A', 7500.00, '2024-02-01'),
    ('TechStart Inc', 'Widget C', 4500.00, '2024-02-10'),
    ('Global Systems', 'Widget B', 6000.00, '2024-02-15'),
    ('Global Systems', 'Widget A', 5500.00, '2024-03-01');

-- Customer data
INSERT INTO customers (name, email, company) VALUES
    ('John Doe', 'john@acmecorp.com', 'Acme Corp'),
    ('Jane Smith', 'jane@techstart.com', 'TechStart Inc'),
    ('Bob Johnson', 'bob@globalsys.com', 'Global Systems'),
    ('Alice Williams', 'alice@example.com', 'Example Corp');

-- User data
INSERT INTO users (username, email, role) VALUES
    ('admin', 'admin@company.com', 'administrator'),
    ('analyst1', 'analyst1@company.com', 'data_analyst'),
    ('manager1', 'manager1@company.com', 'manager'),
    ('developer1', 'dev1@company.com', 'developer');

-- API credentials (sensitive data - target of attack)
INSERT INTO api_credentials (username, password, service_name) VALUES
    ('admin', 'SuperSecret123!', 'admin_panel'),
    ('api_user', 'SecurePass456@', 'rest_api'),
    ('db_admin', 'DatabasePassword789#', 'postgres_db'),
    ('service_account', 'ServiceKey2024$', 'microservice_auth');

