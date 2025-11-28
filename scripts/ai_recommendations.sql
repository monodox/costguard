-- AI-powered recommendations using Snowflake Cortex
-- Generates plain-language insights and recommendations

CREATE OR REPLACE FUNCTION analysis.generate_ai_recommendation(
    warehouse_name STRING,
    efficiency_score FLOAT,
    idle_time_percentage FLOAT,
    cost_spike_detected BOOLEAN
)
RETURNS STRING
LANGUAGE SQL
AS
$$
    SELECT snowflake.cortex.complete(
        'mixtral-8x7b',
        CONCAT(
            'Analyze this Snowflake warehouse performance and provide a concise recommendation:\n',
            'Warehouse: ', warehouse_name, '\n',
            'Efficiency Score: ', efficiency_score::STRING, '%\n',
            'Idle Time: ', idle_time_percentage::STRING, '%\n',
            'Cost Spike Detected: ', CASE WHEN cost_spike_detected THEN 'Yes' ELSE 'No' END, '\n\n',
            'Provide a brief, actionable recommendation (max 100 words) focusing on cost optimization.'
        )
    )
$$;

-- Procedure to update all recommendations
CREATE OR REPLACE PROCEDURE analysis.update_ai_recommendations()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    UPDATE analysis.cost_insights 
    SET ai_recommendation = analysis.generate_ai_recommendation(
        warehouse_name,
        efficiency_score,
        avg_idle_time,
        cost_spike_detected
    )
    WHERE ai_recommendation IS NULL OR ai_recommendation = '';
    
    RETURN 'AI recommendations updated successfully';
END;
$$;

-- Enhanced FinOps analysis with AI recommendations
CREATE OR REPLACE PROCEDURE analysis.run_enhanced_finops_analysis()
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.8'
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'main'
AS
$$
def main(session):
    from snowflake.snowpark.functions import col, sum as sum_, avg, count, when, lit
    
    # Get warehouse usage data
    usage_df = session.table("core.warehouse_usage")
    
    # Calculate metrics by warehouse
    analysis_df = usage_df.group_by("warehouse_name").agg(
        avg("total_credits_used").alias("avg_credits"),
        avg("idle_time_percentage").alias("avg_idle_time"),
        sum_("total_credits_used").alias("total_credits"),
        count("*").alias("usage_days")
    )
    
    # Detect cost spikes (credits > 150% of 7-day average)
    weekly_avg = usage_df.filter(col("usage_date") >= lit("2024-01-01")).group_by("warehouse_name").agg(
        avg("total_credits_used").alias("weekly_avg_credits")
    )
    
    analysis_df = analysis_df.join(weekly_avg, "warehouse_name", "left")
    analysis_df = analysis_df.with_column(
        "cost_spike_detected",
        when(col("avg_credits") > col("weekly_avg_credits") * 1.5, lit(True)).otherwise(lit(False))
    )
    
    # Calculate efficiency score
    analysis_df = analysis_df.with_column(
        "efficiency_score",
        when(col("avg_idle_time") < 20, lit(90))
        .when(col("avg_idle_time") < 50, lit(70))
        .otherwise(lit(40))
    )
    
    # Determine recommended warehouse size
    analysis_df = analysis_df.with_column(
        "recommended_size",
        when(col("avg_credits") < 1, lit("X-SMALL"))
        .when(col("avg_credits") < 5, lit("SMALL"))
        .when(col("avg_credits") < 20, lit("MEDIUM"))
        .when(col("avg_credits") < 50, lit("LARGE"))
        .otherwise(lit("X-LARGE"))
    )
    
    # Save results
    analysis_df.write.mode("overwrite").save_as_table("analysis.cost_insights")
    
    # Generate AI recommendations
    session.call("analysis.update_ai_recommendations")
    
    return "Enhanced FinOps analysis with AI recommendations completed"
$$;