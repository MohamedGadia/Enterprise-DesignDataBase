CREATE SCHEMA IF NOT EXISTS enterprise_catalog;

CREATE TABLE enterprise_catalog.categories(
	category_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	parent_id UUID REFERENCES catalog.categories(category_id) ON DELETE SET NULL,
	name VARCHAR(100) NOT NULL,
	slug VARCHAR(100) UNIQUE NOT NULL,
	description TEXT
);

CREATE TABLE enterprise_catalog.brands(
	brand_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE enterprise_catalog.products(
	product_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	name VARCHAR(100) NOT NULL,
	sku VARCHAR(100) UNIQUE NOT NULL,
	description TEXT,
	category_id UUID REFERENCES enterprise_catalog.categories(category_id),
	brand_id UUID REFERENCES enterprise_catalog.brands(brand_id),
	attributes JSONB,
	is_active BOOLEAN DEFAULT TRUE,
	created_at TIMESTAMPTZ DEFAULT now(),
	updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_product_name ON catalog.products USING gin (to_tsvector('english', name));

CREATE TABLE catalog.inventory(
	inventor_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	product_id UUID REFERENCES enterprise_catalog.products(product_id),
	location_id UUID,
	location_name VARCHAR(100),
	quantity INT NOT NULL DEFAULT 0,
	reserved INT NOT NULL DEFAULT 0,
	safety_stock INT NOT NULL DEFAULT 0,
	last_restock TIMESTAMPTZ
);







