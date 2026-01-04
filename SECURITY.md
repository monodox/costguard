# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |

## Reporting a Vulnerability

We take the security of CostGuard seriously. If you discover a security vulnerability, please follow these steps:

### How to Report

1. **Do NOT** create a public GitHub issue for security vulnerabilities
2. Email security concerns to: [security@costguard.com](mailto:security@costguard.com)
3. Include the following information:
   - Description of the vulnerability
   - Steps to reproduce the issue
   - Potential impact
   - Suggested fix (if available)

### What to Expect

- **Acknowledgment**: We will acknowledge receipt of your report within 48 hours
- **Investigation**: We will investigate and validate the vulnerability within 5 business days
- **Updates**: We will provide regular updates on our progress
- **Resolution**: We aim to resolve critical vulnerabilities within 30 days

### Security Best Practices

When using CostGuard:

1. **Environment Variables**: Never commit `.env.local` files containing credentials
2. **Access Control**: Use least-privilege principles for Snowflake roles
3. **Network Security**: Ensure proper network controls are in place
4. **Regular Updates**: Keep the application updated to the latest version
5. **Monitoring**: Monitor application logs for suspicious activity

### Snowflake Security Considerations

- Ensure your Snowflake account has proper security configurations
- Use strong authentication methods (MFA recommended)
- Regularly review and audit user permissions
- Monitor ACCOUNT_USAGE for unusual patterns

## Responsible Disclosure

We believe in responsible disclosure and will work with security researchers to:
- Understand and validate reported vulnerabilities
- Develop and test fixes
- Coordinate public disclosure timing
- Provide credit to researchers (if desired)

Thank you for helping keep CostGuard secure!