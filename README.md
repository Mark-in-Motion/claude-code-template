# AI-Assisted Project Template

A comprehensive template for starting new AI-assisted development projects with optimal documentation structure and Claude Code integration from day one.

## 🚀 Quick Start

### Option 1: Use GitHub Template
1. Click "Use this template" button on GitHub
2. Create your new repository
3. Clone to your local machine
4. Run the setup script to customize for your project

### Option 2: Manual Setup
```bash
# Clone this template
git clone https://github.com/your-username/claude-code-template.git your-project-name
cd your-project-name

# Run setup script to customize
./scripts/setup.sh    # Unix/Mac
# or
scripts\setup.bat     # Windows

# Initialize as new git repository
rm -rf .git
git init
git add .
git commit -m "Initial commit from AI-assisted project template"
```

## 🏗️ Template Structure

```
├── .gitignore                    # Cross-platform ignore rules
├── README.md                     # This file (customize for your project)
├── CLAUDE.md                     # Claude Code instructions
├── package.json                  # Node.js starter configuration
├── requirements.txt              # Python starter dependencies
├── docs/                         # Documentation system
│   ├── PROJECT_CONTEXT.md        # Project overview and architecture
│   ├── CURRENT_STATUS.md         # Real-time development status
│   ├── ACTIVE_ROADMAP.md         # Feature roadmap and priorities
│   ├── sessions/                 # Development session tracking
│   │   └── latest-session.md     # Template for session notes
│   ├── completed/                # Archive of completed features
│   └── reference/                # Technical references and decisions
├── src/                          # Source code directory
├── public/                       # Static assets and public files
└── scripts/                      # Setup and automation scripts
    ├── setup.sh                  # Unix/Mac setup script
    └── setup.bat                 # Windows setup script
```

## 📋 Setup Instructions

### For Node.js Projects
```bash
# After running setup script
npm install
npm start           # Start development server
npm run build       # Build for production
npm test            # Run tests
```

### For Python Projects
```bash
# After running setup script
pip install -r requirements.txt
python app.py       # Start application
python -m pytest   # Run tests (if pytest installed)
```

### For Other Tech Stacks
1. Remove unused files (`package.json` for non-Node.js, `requirements.txt` for non-Python)
2. Add your tech stack's configuration files
3. Update `CLAUDE.md` with your specific build/test commands
4. Customize documentation templates in `docs/` folder

## 🤖 Claude Code Integration

This template is optimized for development with [Claude Code](https://claude.ai/code). The documentation structure enables:

### Session-Based Development
- Track progress across development sessions
- Maintain context between Claude Code interactions
- Document decisions and architectural choices

### Structured Documentation
- **PROJECT_CONTEXT.md**: High-level project overview
- **CURRENT_STATUS.md**: Real-time implementation tracking
- **ACTIVE_ROADMAP.md**: Prioritized feature development
- **Session tracking**: Detailed logs of development progress

### Best Practices Integration
- Automatic placeholder replacement during setup
- Cross-platform compatibility
- Consistent documentation standards
- Code quality guidelines in CLAUDE.md

## 🛠️ Customization Guide

### 1. Project Basics
After running setup script, customize:
- Project name and description throughout documentation
- Tech stack specific configurations
- Build and test commands in CLAUDE.md

### 2. Documentation
- Update `docs/PROJECT_CONTEXT.md` with your project's specific architecture
- Modify `docs/ACTIVE_ROADMAP.md` with your feature priorities
- Customize session tracking format in `docs/sessions/`

### 3. Development Workflow
- Add project-specific scripts to `scripts/` folder
- Configure your IDE/editor integration
- Set up CI/CD pipelines as needed

## 📝 Development Workflow

### Starting Development
1. Review `docs/CURRENT_STATUS.md` for current state
2. Check `docs/ACTIVE_ROADMAP.md` for next priorities
3. Create session file in `docs/sessions/` if starting significant work
4. Begin development with clear goals

### During Development
- Update status documentation as features are implemented
- Document architectural decisions and patterns
- Test changes thoroughly
- Keep session notes updated with progress and blockers

### Ending Sessions
- Update session documentation with accomplishments
- Move completed features to appropriate status
- Ensure code is in stable, committable state
- Update roadmap if priorities have changed

## 🌟 Features

### Cross-Platform Support
- Works on Windows, Mac, and Linux
- Universal .gitignore covering common scenarios
- Platform-specific setup scripts

### Tech Stack Agnostic
- Basic Node.js and Python starter files included
- Easy to adapt for any technology stack
- Generic folder structure for maximum flexibility

### Documentation-Driven Development
- Structured approach to project documentation
- Session-based progress tracking
- Clear separation of planning, development, and reference materials

### AI-Assisted Optimization
- Designed specifically for Claude Code workflows
- Context preservation across development sessions
- Best practices for AI-assisted development integrated

## 🤝 Contributing

This template is designed to be community-driven:
1. Fork the repository
2. Make improvements or add tech stack specific variants
3. Submit pull request with clear description of changes
4. Help make AI-assisted development more accessible

## 📄 License

This template is open source and available under the MIT License. Use it freely for any project, commercial or personal.

---

## 🚦 Next Steps

1. **Run setup script** to customize this template for your project
2. **Update documentation** with your project-specific information  
3. **Start development** using the session-based workflow
4. **Customize CLAUDE.md** with your specific development commands
5. **Remove this README section** and replace with your project's actual README content

Happy building! 🎉