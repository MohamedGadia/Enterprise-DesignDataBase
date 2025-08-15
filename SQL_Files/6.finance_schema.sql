CREATE SCHEMA IF NOT EXISTS finance;

CREATE TABLE finance.invoices(
	invoice_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	tenant_id UUID REFERENCES platform.tenants(tenant_id) ON DELETE CASCADE,
	order_id UUID REFERENCES sales.orders(order_id) ON DELETE SET NULL,
	customer_id UUID REFERENCES crm.customers(customer_id) ON DELETE SET NULL,
	invoice_number VARCHAR(100),
	subtotal NUMERIC(12, 2) NOT NULL,
	tax NUMERIC(12, 2) NOT NULL,
	total NUMERIC(12, 2) NOT NULL,
	status VARCHAR(50),
	issued_at TIMESTAMPTZ DEFAULT now(),
	due_date TIMESTAMP,
	metadata JSONB
);

CREATE TYPE finance.transaction_type AS ENUM ('cash', 'credit', 'debit');

CREATE TABLE finance.transactions(
	transaction_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	invoice_id UUID REFERENCES finance.invoices(invoice_id),
	order_id UUID REFERENCES sales.orders(order_id),
	customer_id UUID REFERENCES crm.customers(customer_id),
	amount NUMERIC(12, 2),
	currency CHAR(3) DEFAULT 'USD',
	transaction_type finance.transaction_type,
	recorded_at TIMESTAMPTZ DEFAULT now(),
	metadata JSONB
);






