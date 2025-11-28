-- CostGuard Data Ingestion
-- Queries to populate warehouse usage data from Snowflake system tables

-- Create view for warehouse usage metrics
CREATE OR REPLACE VIEW core.warehouse_usage_source AS
SELECT 
    wh.warehouse_name,
    DATE(qh.start_time) as usage_date,
    SUM(qh.total_elapsed_time/1000) as total_execution_time_seconds,
    SUM(wh.credits_used_compute) as total_credits_used,
    COUNT(qh.query_id) as query_count,
    AVG(qh.queued_provisioning_time + qh.queued_repair_time + qh.queued_overload_time)/1000 as avg_queue_time_seconds,
    -- Calculate idle time percentage
    (1 - (SUM(qh.total_elapsed_time/1000) / (24 * 3600))) * 100 as idle_time_percentage
FROM 
    snowflake.account_usage.query_history qh
    JOIN snowflake.account_usage.warehouse_metering_history wh 
        ON qh.warehouse_name = wh.warehouse_name 
        AND DATE(qh.start_time) = DATE(wh.start_time)
WHERE 
    qh.start_time >= DATEADD(day, -30, CURRENT_DATE())
    AND qh.warehouse_name IS NOT NULL
GROUP BY 
    wh.warehouse_name, 
    DATE(qh.start_time);

-- Procedure to refresh warehouse usage data
CREATE OR REPLACE PROCEDURE core.refresh_usage_data()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    -- Insert new usage data
    INSERT INTO core.warehouse_usage (
        warehouse_name, usage_date, total_credits_used, 
        total_execution_time_seconds, query_count, 
        avg_queue_time_seconds, idle_time_percentage
    )
    SELECT 
        warehouse_name, usage_date, total_credits_used,
        total_execution_time_seconds, query_count,
        avg_queue_time_seconds, idle_time_percentage
    FROM core.warehouse_usage_source
    WHERE usage_date NOT IN (
        SELECT DISTINCT usage_date 
        FROM core.warehouse_usage 
        WHERE warehouse_name = warehouse_usage_source.warehouse_name
    );
    
    RETURN 'Usage data refreshed successfully';
END;
$$;

-- Create task for automated data refresh (optional)
CREATE OR REPLACE TASK core.daily_usage_refresh
    WAREHOUSE = 'COMPUTE_WH'
    SCHEDULE = 'USING CRON 0 6 * * * UTC'  -- Daily at 6 AM UTC
AS
    CALL core.refresh_usage_data();

-- Enable the task (uncomment to activate)
-- ALTER TASK core.daily_usage_refresh RESUME;