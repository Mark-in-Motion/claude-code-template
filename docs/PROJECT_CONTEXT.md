# PROJECT_CONTEXT.md

## Project Overview

**Project Name:** {{PROJECT_NAME}}
**Description:** {{DESCRIPTION}}
**Created:** {{DATE}}
**Last Updated:** {{DATE}}

## Project Goals

### Primary Objectives
- {{PRIMARY_GOAL_1}}
- {{PRIMARY_GOAL_2}}
- {{PRIMARY_GOAL_3}}

### Success Metrics
- {{SUCCESS_METRIC_1}}
- {{SUCCESS_METRIC_2}}
- {{SUCCESS_METRIC_3}}

## Technical Architecture

### Tech Stack
**Language:** {{PROGRAMMING_LANGUAGE}}
**Framework:** {{FRAMEWORK}}
**Database:** {{DATABASE}}
**Deployment:** {{DEPLOYMENT_PLATFORM}}

### System Architecture
```
{{ARCHITECTURE_DIAGRAM}}
# Example:
# Frontend (React) → API Gateway → Backend (Node.js) → Database (PostgreSQL)
# 
# Components:
# - User Interface: React with TypeScript
# - API Layer: Express.js with REST endpoints
# - Business Logic: Node.js services
# - Data Layer: PostgreSQL with Prisma ORM
# - Authentication: JWT tokens
# - File Storage: AWS S3
```

### Key Dependencies
```json
{{KEY_DEPENDENCIES}}
// Example for Node.js:
// {
//   "express": "^4.18.0",     // Web framework
//   "prisma": "^5.0.0",       // Database ORM
//   "jsonwebtoken": "^9.0.0", // Authentication
//   "multer": "^1.4.5",       // File uploads
//   "cors": "^2.8.5"          // Cross-origin requests
// }
```

## Development Environment

### Prerequisites
```bash
{{PREREQUISITES}}
# Example:
# Node.js >= 16.0.0
# PostgreSQL >= 13.0
# Redis >= 6.0 (for caching)
# Docker (for containerization)
```

### Environment Setup
```bash
{{ENVIRONMENT_SETUP_STEPS}}
# Example steps:
# 1. Clone repository: git clone {{REPOSITORY_URL}}
# 2. Install dependencies: npm install
# 3. Set up database: createdb {{PROJECT_NAME}}
# 4. Copy environment file: cp .env.example .env
# 5. Run migrations: npm run migrate
# 6. Start development server: npm run dev
```

### Configuration
```bash
{{ENVIRONMENT_VARIABLES}}
# Required environment variables:
# DATABASE_URL="postgresql://localhost/{{PROJECT_NAME}}"
# JWT_SECRET="your-secret-key"
# API_PORT=3000
# NODE_ENV=development
```

## Project Structure

```
{{PROJECT_NAME}}/
├── src/                          # Source code
│   ├── {{MAIN_DIRECTORIES}}      # Main application directories
│   └── {{UTILITY_DIRECTORIES}}   # Utility and helper directories
├── docs/                         # Documentation
│   ├── PROJECT_CONTEXT.md        # This file
│   ├── CURRENT_STATUS.md         # Development status
│   ├── ACTIVE_ROADMAP.md         # Feature roadmap
│   └── sessions/                 # Development sessions
├── {{CONFIG_FILES}}              # Configuration files
└── {{OTHER_DIRECTORIES}}         # Other project directories

# Example structure for a web app:
# src/
# ├── components/        # Reusable UI components
# ├── pages/            # Page components/routes
# ├── services/         # API and business logic
# ├── utils/            # Helper functions
# ├── types/            # TypeScript type definitions
# └── tests/            # Test files
```

## Core Features

### Feature Set
1. **{{FEATURE_1}}**
   - {{FEATURE_1_DESCRIPTION}}
   - Key components: {{FEATURE_1_COMPONENTS}}

2. **{{FEATURE_2}}**
   - {{FEATURE_2_DESCRIPTION}}  
   - Key components: {{FEATURE_2_COMPONENTS}}

3. **{{FEATURE_3}}**
   - {{FEATURE_3_DESCRIPTION}}
   - Key components: {{FEATURE_3_COMPONENTS}}

### User Workflows
```
{{USER_WORKFLOW_1}}
# Example: User Registration Flow
# 1. User visits registration page
# 2. User fills out form with email/password
# 3. System validates input and creates account
# 4. System sends confirmation email
# 5. User confirms email and account is activated
```

## External Integrations

### APIs and Services
- **{{EXTERNAL_SERVICE_1}}**: {{SERVICE_1_PURPOSE}}
- **{{EXTERNAL_SERVICE_2}}**: {{SERVICE_2_PURPOSE}}
- **{{EXTERNAL_SERVICE_3}}**: {{SERVICE_3_PURPOSE}}

### Third-Party Libraries
```
{{THIRD_PARTY_INTEGRATIONS}}
# Example:
# - Stripe: Payment processing
# - SendGrid: Email delivery
# - AWS S3: File storage
# - Google Analytics: User tracking
```

## Development Guidelines

### Code Standards
- **Style Guide:** {{STYLE_GUIDE}}
- **Linting:** {{LINTING_TOOL}}
- **Testing:** {{TESTING_FRAMEWORK}}
- **Documentation:** {{DOCUMENTATION_STANDARD}}

### Git Workflow
```
{{GIT_WORKFLOW}}
# Example:
# - main: Production-ready code
# - develop: Integration branch for features
# - feature/*: Individual feature branches
# - hotfix/*: Emergency production fixes
```

### Deployment Process
```
{{DEPLOYMENT_PROCESS}}
# Example:
# 1. Feature complete and tested locally
# 2. Create pull request to develop branch
# 3. Code review and automated tests pass
# 4. Merge to develop and deploy to staging
# 5. QA testing on staging environment
# 6. Merge to main and deploy to production
```

## Security Considerations

### Authentication & Authorization
- {{AUTH_METHOD}}: {{AUTH_DESCRIPTION}}
- {{PERMISSION_SYSTEM}}: {{PERMISSION_DESCRIPTION}}

### Data Protection
- {{DATA_ENCRYPTION}}: {{ENCRYPTION_DESCRIPTION}}
- {{DATA_BACKUP}}: {{BACKUP_DESCRIPTION}}

### Security Measures
- {{SECURITY_MEASURE_1}}: {{MEASURE_1_DESCRIPTION}}
- {{SECURITY_MEASURE_2}}: {{MEASURE_2_DESCRIPTION}}

## Performance Considerations

### Optimization Strategies
- {{PERFORMANCE_STRATEGY_1}}: {{STRATEGY_1_DESCRIPTION}}
- {{PERFORMANCE_STRATEGY_2}}: {{STRATEGY_2_DESCRIPTION}}

### Monitoring
- {{MONITORING_TOOL}}: {{MONITORING_DESCRIPTION}}
- {{LOGGING_SYSTEM}}: {{LOGGING_DESCRIPTION}}

---

**Template Notes:**
This file should be updated whenever:
- Project scope or goals change
- New major technical decisions are made
- Architecture is modified or refactored
- New integrations are added
- Development process changes

Replace all `{{PLACEHOLDER}}` values with your project-specific information.