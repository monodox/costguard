# CostGuard - Snowflake FinOps Native App

CostGuard is an install-in-minutes Snowflake Native App that automatically analyzes warehouse usage and cloud spend to detect cost spikes, idle compute, and oversized warehouses.

## Features

- **Automated Cost Analysis**: Detects cost spikes and inefficient warehouse usage
- **Idle Compute Detection**: Identifies warehouses with high idle time
- **Warehouse Sizing Recommendations**: Suggests optimal warehouse sizes
- **AI-Powered Insights**: Plain-language recommendations using Snowflake Cortex
- **Interactive Dashboard**: Streamlit-based UI for easy visualization
- **Automated Monitoring**: Optional scheduled tasks for continuous monitoring

## Quick Start

1. **Install the App**: Deploy as a Snowflake Native App
2. **Grant Database Access**: Provide access to databases you want to monitor
3. **Load Usage Data**: Run the data ingestion procedure
4. **Run Analysis**: Execute FinOps analysis to generate insights
5. **View Dashboard**: Access the Streamlit dashboard for interactive reports

## Core Components

### Data Ingestion
- Connects to Snowflake system tables (ACCOUNT_USAGE)
- Aggregates warehouse usage metrics
- Calculates idle time and efficiency scores

### FinOps Analysis
- Detects cost spikes (>150% of average)
- Calculates warehouse efficiency scores
- Recommends optimal warehouse sizes
- Generates AI-powered recommendations

### Dashboard
- Interactive Streamlit interface
- Real-time cost and usage visualization
- Actionable insights and recommendations

## Usage

### Manual Analysis
```sql
-- Refresh usage data
CALL core.refresh_usage_data();

-- Run FinOps analysis
CALL analysis.run_enhanced_finops_analysis();
```

### Automated Monitoring
```sql
-- Enable daily data refresh
ALTER TASK core.daily_usage_refresh RESUME;
```

### View Results
Access the Streamlit dashboard or query the analysis tables directly:
```sql
SELECT * FROM analysis.cost_insights;
```

## Configuration

The app is designed to be fully reusable across accounts through configuration. Customize analysis thresholds and recommendations in the setup scripts.

## Support

For issues or questions, refer to the Snowflake Native App documentation or contact your Snowflake administrator.