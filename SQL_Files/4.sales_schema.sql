CREATE SCHEMA IF NOT EXISTS sales;

CREATE TYPE sales.order_status AS ENUM ('draft','placed','confirmed','shipped','delivered','cancelled','refunded');

CREATE TABLE sales.orders(
	order_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	tenant_id UUID REFERENCES platform.tenants(tenant_id),
	customer_id UUID REFERENCES crm.customers(customer_id),
	order_number BIGINT UNIQUE,
	status sales.order_status DEFAULT 'draft',
	subtotal NUMERIC(12, 2) NOT NULL DEFAULT 0,
	tax NUMERIC(12, 2) NOT NULL DEFAULT 0,
	shipping NUMERIC(12, 2) NOT NULL DEFAULT 0,
	total NUMERIC(12, 2) NOT NULL DEFAULT 0,
	currenct CHAR(3) DEFAULT 'USD',
	created_at TIMESTAMPTZ DEFAULT now(),
	placed_at TIMESTAMPTZ
);

-- Sequence and trigger to populate order_number per tenant
CREATE SEQUENCE IF NOT EXISTS sales.order_seq START 100000;

-- Populate order_number using nextval
CREATE OR REPLACE FUNCTION sales.set_order_number()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
	IF NEW.order_number IS NULL
	THEN
		NEW.order_nember := NEXTVAL('sales.order_seq');
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER trg_set_order_number BEFORE INSERT ON sales.orders
FOR EACH ROW EXECUTE FUNCTION sales.set_order_number();


CREATE TABLE sales.order_items(
	order_item_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	oder_id UUID REFERENCES sales.orders(order_id),
	product_id UUID REFERENCES enterprise_catalog.products(product_id) ON DELETE SET NULL,
	sku VARCHAR(100),
	quantity INT NOT NULL DEFAULT 1,
	unit_price NUMERIC(12, 2) NOT NULL,
	total_price NUMERIC(12, 2) NOT NULL,
	metadata JSONB
);

CREATE TYPE sales.payment_status AS ENUM ('faild', 'panding', 'paid')

CREATE TABLE payments(
	payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	order_id UUID REFERENCES sales.orders(order_id) ON DELETE CASCADE,
	provider VARCHAR(100),
	provider_ref VARCHAR(255),
	amount INT NOT NULL,
	currency CHAR(3) DEFAULT 'USD',
	status sales.payment_status,
	paid_at TIMESTAMPTZ,
	created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE sales.shipments(
	shipment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	order_id UUID REFERENCES sales.orders(order_id),
	carrier VARCHAR(100) NOT NULL,
	tracking_number VARCHAR(255),
	shipped_at TIMESTAMPTZ,
	delivered_at TIMESTAMPTZ,
	status VARCHAR(100) NOT NULL,
	metadata JSONB
);




