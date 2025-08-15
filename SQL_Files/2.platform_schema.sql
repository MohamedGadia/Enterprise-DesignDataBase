CREATE SCHEMA IF NOT EXISTS platform;

CREATE TABLE platform.tenants(
	tenant_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	name VARCHAR(100) UNIQUE NOT NULL,
	slug VARCHAR(100) UNIQUE NOT NULL,
	plan VARCHAR(100),
	created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE platform.audit_logs(
	audit_id BIGSERIAL PRIMARY KEY,
	user_id UUID REFERENCES auth.users(user_id) ON DELETE SET NULL,
	tenant_id UUID REFERENCES platform.tenants(tenant_id),
	action VARCHAR(100) NOT NULL,
	object_type VARCHAR(100),
	object_id UUID,
	changes JSONB,
	created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE platform.attachments(
	attachment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	tenant_id UUID REFERENCES platform.tenants(tenant_id),
	owner_id UUID,
	file_name VARCHAR(255),
	file_type VARCHAR(50),
	size_bytes BIGINT,
	storage_url TEXT,
	created_at TIMESTAMPTZ DEFAULT now()
);






