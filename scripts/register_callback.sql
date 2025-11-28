-- Register callback for consumer database reference
-- This script runs when the app is granted access to a consumer database

CREATE OR REPLACE PROCEDURE core.register_consumer_database(database_name STRING)
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    -- Log the registration
    INSERT INTO core.app_logs (event_type, message, created_at)
    VALUES ('DATABASE_REGISTERED', 'Consumer database registered: ' || database_name, CURRENT_TIMESTAMP());
    
    -- Grant necessary permissions for monitoring
    EXECUTE IMMEDIATE 'GRANT MONITOR ON DATABASE ' || database_name || ' TO APPLICATION ROLE costguard_role';
    
    RETURN 'Consumer database ' || database_name || ' registered successfully';
END;
$$;

-- Create logging table
CREATE TABLE IF NOT EXISTS core.app_logs (
    log_id NUMBER AUTOINCREMENT,
    event_type STRING,
    message STRING,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);