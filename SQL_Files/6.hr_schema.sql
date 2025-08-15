CREATE SCHEMA IF NOT EXISTS hr;

CREATE TABLE hr.employees(
	employee_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	tenant_id UUID REFERENCES platform.tenants(tenant_id) ON DELETE CASCADE,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	email CITEXT UNIQUE,
	phone VARCHAR(100),
	hire_date DATE,
	job_title VARCHAR(100),
	department VARCHAR(100),
	manager_id UUID REFERENCES hr.employees(employee_id) ON DELETE SET NULL,
	metadata JSONB,
	created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE hr.payroll(
	payroll_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	employee_id UUID  REFERENCES hr.employees(employee_id),
	period_start DATE,
	period_end DATE,
	gross NUMERIC(14, 2) NOT NULL,
	net NUMERIC(14, 2) NOT NULL,
	deducation JSONB,
	created_at TIMESTAMPTZ DEFAULT now()
);