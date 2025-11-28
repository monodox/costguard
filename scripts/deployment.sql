-- CostGuard Deployment Script
-- Use this to deploy and test the application

-- Create application package (run as ACCOUNTADMIN)
CREATE APPLICATION PACKAGE IF NOT EXISTS costguard_package;

-- Upload application files
-- Note: Use SnowSQL or Snowflake CLI to upload the app directory

-- Create application from package
CREATE APPLICATION IF NOT EXISTS costguard 
FROM APPLICATION PACKAGE costguard_package;

-- Grant necessary privileges
GRANT USAGE ON APPLICATION costguard TO ROLE sysadmin;

-- Test the installation
USE APPLICATION costguard;

-- Verify schemas were created
SHOW SCHEMAS;

-- Test data ingestion
CALL core.refresh_usage_data();

-- Test analysis
CALL analysis.run_enhanced_finops_analysis();

-- Check results
SELECT COUNT(*) as usage_records FROM core.warehouse_usage;
SELECT COUNT(*) as analysis_records FROM analysis.cost_insights;

-- Access Streamlit dashboard
-- Navigate to: Applications > CostGuard > Streamlit Dashboard