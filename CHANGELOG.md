# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial project setup and documentation

## [1.0.0] - 2024-01-XX

### Added
- Initial release of CostGuard Snowflake Native App
- Automated cost analysis and spike detection
- Idle compute detection functionality
- Warehouse sizing recommendations
- AI-powered insights using Snowflake Cortex
- Interactive Streamlit dashboard
- Automated monitoring with scheduled tasks
- Data ingestion from Snowflake ACCOUNT_USAGE
- FinOps analysis with efficiency scoring
- Configuration management for multi-account deployment

### Features
- **Cost Analysis**: Detects cost spikes >150% of average usage
- **Efficiency Scoring**: Calculates warehouse utilization metrics
- **Smart Recommendations**: AI-generated optimization suggestions
- **Real-time Dashboard**: Interactive visualization of costs and usage
- **Automated Tasks**: Scheduled data refresh and analysis
- **Multi-account Support**: Configurable for different Snowflake accounts

### Technical
- Snowflake Native App architecture
- Streamlit-based user interface
- SQL-based data processing
- Environment-based configuration
- Comprehensive error handling
- Security best practices implementation

### Documentation
- Complete README with installation guide
- Security policy and vulnerability reporting
- Code of conduct for contributors
- Contributing guidelines
- MIT license

## [0.1.0] - 2024-01-XX

### Added
- Project initialization
- Basic project structure
- Core SQL scripts for data analysis
- Streamlit dashboard prototype
- Snowflake CLI configuration

---

## Release Notes

### Version 1.0.0
This is the initial stable release of CostGuard. The application provides comprehensive FinOps capabilities for Snowflake environments, including automated cost monitoring, efficiency analysis, and actionable recommendations.

**Key Highlights:**
- Easy installation as Snowflake Native App
- Zero-configuration cost monitoring
- AI-powered optimization recommendations
- Interactive dashboard for data visualization
- Automated scheduling for continuous monitoring

**System Requirements:**
- Snowflake account with ACCOUNTADMIN privileges
- Access to ACCOUNT_USAGE schema
- Snowflake CLI for deployment

**Known Issues:**
- Dashboard requires active Snowflake session
- Large datasets may require performance tuning
- Some recommendations require manual validation

**Upgrade Path:**
This is the initial release. Future versions will maintain backward compatibility.