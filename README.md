# CostGuard - Snowflake FinOps Native App

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Snowflake](https://img.shields.io/badge/Snowflake-Native%20App-blue)](https://www.snowflake.com/)

CostGuard is an install-in-minutes Snowflake Native App that automatically analyzes warehouse usage and cloud spend to detect cost spikes, idle compute, and oversized warehouses.

## 🚀 Features

- **Automated Cost Analysis**: Detects cost spikes and inefficient warehouse usage
- **Idle Compute Detection**: Identifies warehouses with high idle time
- **Warehouse Sizing Recommendations**: Suggests optimal warehouse sizes
- **AI-Powered Insights**: Plain-language recommendations using Snowflake Cortex
- **Interactive Dashboard**: Streamlit-based UI for easy visualization
- **Automated Monitoring**: Optional scheduled tasks for continuous monitoring

## 📋 Prerequisites

- Snowflake account with ACCOUNTADMIN privileges
- Snowflake CLI installed
- Access to ACCOUNT_USAGE schema

## 🛠️ Installation

### 1. Clone Repository
```bash
git clone <repository-url>
cd costguard
```

### 2. Configure Environment
```bash
cp .env.example .env.local
# Edit .env.local with your Snowflake credentials
```

### 3. Deploy Native App
```bash
snow connection add --connection-name costguard_dev
snow app deploy --connection costguard_dev
```

## 🎯 Quick Start

1. **Install the App**: Deploy as a Snowflake Native App
2. **Grant Database Access**: Provide access to databases you want to monitor
3. **Load Usage Data**: Run the data ingestion procedure
4. **Run Analysis**: Execute FinOps analysis to generate insights
5. **View Dashboard**: Access the Streamlit dashboard for interactive reports

## 🏗️ Core Components

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

## 📖 Usage

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

## ⚙️ Configuration

The app is designed to be fully reusable across accounts through configuration. Customize analysis thresholds and recommendations in the setup scripts.

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute to this project.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔒 Security

See [SECURITY.md](SECURITY.md) for our security policy and reporting vulnerabilities.

## 📝 Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes and version history.

## 💬 Support

For issues or questions:
- Create an issue in this repository
- Refer to the Snowflake Native App documentation
- Contact your Snowflake administrator