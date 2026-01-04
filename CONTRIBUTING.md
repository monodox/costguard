# Contributing to CostGuard

Thank you for your interest in contributing to CostGuard! This document provides guidelines and information for contributors.

## 🚀 Getting Started

### Prerequisites

- Snowflake account with ACCOUNTADMIN privileges
- Snowflake CLI installed and configured
- Git for version control
- Basic knowledge of SQL and Python/Streamlit

### Development Setup

1. **Fork and Clone**
   ```bash
   git clone https://github.com/your-username/costguard.git
   cd costguard
   ```

2. **Environment Setup**
   ```bash
   cp .env.example .env.local
   # Edit .env.local with your Snowflake credentials
   ```

3. **Install Dependencies**
   ```bash
   # Install Snowflake CLI if not already installed
   pip install snowflake-cli-labs
   ```

4. **Test Deployment**
   ```bash
   snow connection add --connection-name costguard_dev
   snow app deploy --connection costguard_dev
   ```

## 📋 How to Contribute

### Reporting Issues

Before creating an issue, please:
- Check existing issues to avoid duplicates
- Use the issue templates when available
- Provide clear, detailed descriptions
- Include steps to reproduce bugs
- Add relevant labels

### Suggesting Features

When suggesting new features:
- Explain the use case and business value
- Describe the proposed solution
- Consider implementation complexity
- Discuss potential alternatives

### Code Contributions

1. **Create a Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make Changes**
   - Follow existing code style and patterns
   - Add comments for complex logic
   - Update documentation as needed
   - Test your changes thoroughly

3. **Commit Guidelines**
   ```bash
   git commit -m "type(scope): description"
   ```
   
   Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`
   
   Examples:
   - `feat(dashboard): add cost trend visualization`
   - `fix(analysis): correct idle time calculation`
   - `docs(readme): update installation instructions`

4. **Submit Pull Request**
   - Use the PR template
   - Link related issues
   - Provide clear description of changes
   - Request appropriate reviewers

## 🏗️ Project Structure

```
costguard/
├── app/                    # Native app configuration
│   └── manifest.yml       # App manifest
├── scripts/               # SQL setup and deployment scripts
│   ├── setup.sql         # Initial setup
│   ├── deployment.sql    # Deployment procedures
│   └── ai_recommendations.sql
├── sql/                   # Core SQL logic
│   └── data_ingestion.sql
├── streamlit/            # Dashboard components
│   └── dashboard.py      # Main dashboard
├── .env.example          # Environment template
├── snowflake.yml         # Snowflake CLI config
└── README.md
```

## 🧪 Testing

### Manual Testing
- Test all SQL procedures in your Snowflake environment
- Verify dashboard functionality with sample data
- Test deployment process from scratch
- Validate error handling scenarios

### Code Quality
- Follow SQL best practices
- Use consistent naming conventions
- Add appropriate error handling
- Document complex queries

## 📝 Documentation

### Code Documentation
- Comment complex SQL logic
- Document function parameters and return values
- Explain business logic and calculations
- Update inline documentation for changes

### User Documentation
- Update README for new features
- Add examples for new functionality
- Update configuration instructions
- Maintain changelog entries

## 🔍 Code Review Process

### For Contributors
- Ensure code follows project standards
- Test changes thoroughly
- Update documentation
- Respond to review feedback promptly

### For Reviewers
- Focus on functionality and maintainability
- Check for security implications
- Verify documentation updates
- Test changes when possible

## 🎯 Development Guidelines

### SQL Standards
- Use uppercase for SQL keywords
- Use meaningful table and column aliases
- Include appropriate indexes and constraints
- Optimize for performance

### Python/Streamlit Standards
- Follow PEP 8 style guidelines
- Use type hints where appropriate
- Handle errors gracefully
- Keep functions focused and testable

### Security Considerations
- Never commit credentials or secrets
- Use parameterized queries
- Validate user inputs
- Follow least-privilege principles

## 🏷️ Release Process

1. **Version Bumping**
   - Update version in manifest.yml
   - Update CHANGELOG.md
   - Tag release in git

2. **Testing**
   - Full deployment test
   - Feature validation
   - Performance verification

3. **Documentation**
   - Update README if needed
   - Verify all docs are current
   - Update API documentation

## 💬 Communication

### Channels
- GitHub Issues: Bug reports and feature requests
- GitHub Discussions: General questions and ideas
- Pull Requests: Code review and collaboration

### Response Times
- Issues: We aim to respond within 48 hours
- Pull Requests: Initial review within 3-5 business days
- Security Issues: See SECURITY.md for expedited process

## 🎉 Recognition

Contributors will be recognized in:
- CHANGELOG.md for significant contributions
- README.md contributors section
- Release notes for major features

## 📜 Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you agree to uphold this code.

## ❓ Questions?

If you have questions about contributing:
- Check existing documentation
- Search closed issues and discussions
- Create a new discussion for general questions
- Create an issue for specific problems

Thank you for contributing to CostGuard! 🚀