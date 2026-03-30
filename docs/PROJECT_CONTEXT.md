# PROJECT_CONTEXT.md

## Project Overview

**Project Name:** {{PROJECT_NAME}}
**Description:** {{DESCRIPTION}}
**Overview:** {{PROJECT_OVERVIEW}}
**Created:** {{DATE}}
**Last Updated:** {{DATE}}

## Technical Architecture

### Tech Stack
**Language:** {{PROGRAMMING_LANGUAGE}}
**Framework:** {{FRAMEWORK}}
**Database:** {{DATABASE}}
**Deployment:** {{DEPLOYMENT_PLATFORM}}

## Development Environment

### Environment Variables
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
├── src/
│   ├── components/                # Reusable UI components
│   ├── services/                  # API and business logic
│   ├── utils/                     # Shared helpers
│   └── hooks/                     # Reusable hooks
├── docs/                          # Documentation
│   ├── PROJECT_CONTEXT.md
│   ├── CURRENT_STATUS.md
│   ├── ACTIVE_ROADMAP.md
│   └── sessions/
└── {{CONFIG_FILES}}               # Configuration files
```

**Template Notes:**
This file should be updated whenever the project name, description, tech stack, structure, or environment variables change.

Replace all `{{PLACEHOLDER}}` values with your project-specific information.
