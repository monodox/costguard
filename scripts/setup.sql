-- CostGuard Setup Script
-- Creates the core schema and objects for FinOps analysis

CREATE APPLICATION ROLE IF NOT EXISTS costguard_role;
CREATE SCHEMA IF NOT EXISTS core;
CREATE SCHEMA IF NOT EXISTS analysis;
CREATE SCHEMA IF NOT EXISTS streamlit;

-- Grant permissions
GRANT USAGE ON SCHEMA core TO APPLICATION ROLE costguard_role;
GRANT USAGE ON SCHEMA analysis TO APPLICATION ROLE costguard_role;
GRANT USAGE ON SCHEMA streamlit TO APPLICATION ROLE costguard_role;

-- Create warehouse usage analysis table
CREATE OR REPLACE TABLE core.warehouse_usage (
    warehouse_name STRING,
    usage_date DATE,
    total_credits_used FLOAT,
    total_execution_time_seconds FLOAT,
    query_count INTEGER,
    avg_queue_time_seconds FLOAT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

-- Create cost analysis results table
CREATE OR REPLACE TABLE analysis.cost_insights (
    warehouse_name STRING,
    analysis_date DATE,
    cost_spike_detected BOOLEAN,
    idle_time_percentage FLOAT,
    efficiency_score FLOAT,
    recommended_size STRING,
    ai_recommendation STRING,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

-- Create Snowpark procedure for FinOps analysis
CREATE OR REPLACE PROCEDURE analysis.run_finops_analysis()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    -- Add sample data if none exists
    INSERT INTO core.warehouse_usage (
        warehouse_name, usage_date, total_credits_used, 
        total_execution_time_seconds, query_count, 
        avg_queue_time_seconds
    ) 
    SELECT * FROM VALUES 
    ('COMPUTE_WH', CURRENT_DATE(), 2.5, 3600, 150, 0.2),
    ('ANALYTICS_WH', CURRENT_DATE(), 5.2, 7200, 300, 0.5),
    ('DEV_WH', CURRENT_DATE(), 1.1, 1800, 75, 0.1)
    WHERE NOT EXISTS (SELECT 1 FROM core.warehouse_usage);
    
    -- Clear and insert analysis results
    DELETE FROM analysis.cost_insights;
    
    INSERT INTO analysis.cost_insights (
        warehouse_name, analysis_date, cost_spike_detected, 
        efficiency_score, recommended_size, ai_recommendation
    )
    SELECT 
        warehouse_name,
        CURRENT_DATE(),
        CASE WHEN total_credits_used > 3 THEN TRUE ELSE FALSE END,
        CASE WHEN total_credits_used < 2 THEN 85 ELSE 65 END,
        CASE WHEN total_credits_used < 2 THEN 'SMALL' ELSE 'MEDIUM' END,
        'Optimize based on usage patterns'
    FROM core.warehouse_usage;
    
    RETURN 'Analysis completed successfully';
END;
$$;

-- Create Streamlit app
CREATE OR REPLACE STREAMLIT streamlit.costguard_dashboard
FROM 'streamlit'
MAIN_FILE = 'dashboard.py';

-- Grant permissions on objects
GRANT ALL ON TABLE core.warehouse_usage TO APPLICATION ROLE costguard_role;
GRANT ALL ON TABLE analysis.cost_insights TO APPLICATION ROLE costguard_role;
GRANT USAGE ON PROCEDURE analysis.run_finops_analysis() TO APPLICATION ROLE costguard_role;
GRANT USAGE ON STREAMLIT streamlit.costguard_dashboard TO APPLICATION ROLE costguard_role;