CREATE SCHEMA IF NOT EXISTS crm;

CREATE TABLE crm.customers(
	customer_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	tenant_id UUID REFERENCES platform.tenants(tenant_id) ON DELETE CASCADE,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	email TEXT[] NOT NULL,
	phone TEXT[] NOT NULL ,
	addresses JSONB NOT NULL,
	metadata JSONB,
	created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TYPE crm.lead_status AS ENUM ('new','contacted','qualified','unqualified','converted');

CREATE TABLE crm.status(
	lead_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	tenant_id UUID REFERENCES platform.tenants(tenant_id) ON DELETE CASCADE,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	source VARCHAR(255),
	status crm.lead_status DEFAULT 'new',
	contact_info JSONB,
	assigned_to UUID REFERENCES auth.users(user_id),
	created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE crm.interactions(
	interaction_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	customer_id UUID REFERENCES crm.customers(customer_id) ON DELETE CASCADE,
	user_id UUID REFERENCES platform.users(user_id),
	channel VARCHAR(100),
	note TEXT,
	created_at TIMESTAMPTZ DEFAULT now()
);



