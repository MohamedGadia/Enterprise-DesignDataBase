-- Enable Extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "citext";

-- Create Auth schema
CREATE SCHEMA IF NOT EXISTS auth;
CREATE TYPE auth.user_status AS ENUM ('active', 'inactive', 'suspended', 'pending');


CREATE TABLE auth.users(
	user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	user_name VARCHAR(255) UNIQUE NOT NULL,
	email CITEXT UNIQUE NOT NULL,
	password_hash TEXT NOT NULL,
	full_name VARCHAR(255),
	status auth.user_status DEFAULT 'pending',
	created_at TIMESTAMPTZ DEFAULT NOW(),
	last_login TIMESTAMPTZ 
);

CREATE TABLE auth.roles(
	role_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	role_name VARCHAR(100) UNIQUE NOT NULL,
	description TEXT
);

CREATE TABLE auth.user_role(
	user_id UUID REFERENCES auth.users(user_id) ON DELETE CASCADE,
	role_id UUID REFERENCES auth.roles(role_id) ON DELETE CASCADE,
	granted_at TIMESTAMPTZ DEFAULT NOW(),
	PRIMARY KEY(user_id, role_id)
);


CREATE TABLE auth.sessions(
	session_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	user_id UUID REFERENCES auth.users(user_id) ON DELETE CASCADE,
	country VARCHAR(50),
	token TEXT NOT NULL,
	user_agent VARCHAR(100),
	ip INET,
	created_at TIMESTAMPTZ DEFAULT NOW(),
	expires_at TIMESTAMPTZ
);