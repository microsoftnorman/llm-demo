# GitHub Copilot Instructions for llm-demo

## Project Overview
This is an LLM (Large Language Model) demo project that focuses on setting up and managing Ollama, an open-source tool for running large language models locally. The project provides automated setup scripts for deploying various LLM models.

## Project Context
- **Primary Purpose**: Automate the installation and configuration of Ollama service with multiple LLM models
- **Target Environment**: Linux systems (Ubuntu/Debian-based)
- **Key Dependencies**: Ollama, systemd
- **Supported Models**: phi3, llama3, llama3:70b, codellama, mixtral

## Coding Standards and Style Guidelines

### Shell Scripting (Bash)
- Use `#!/bin/bash` shebang for all bash scripts
- Include descriptive comments for complex operations
- Use meaningful function names (e.g., `loadmodel()`)
- Implement error handling with exit codes
- Check for file existence before operations
- Use proper quoting for variables to prevent word splitting
- Follow the existing indentation style (2 spaces)

### Best Practices
- Always validate prerequisites (e.g., check if files exist before modifying)
- Provide user feedback with `echo` statements
- Use conditional checks to avoid redundant operations
- Implement idempotent scripts (safe to run multiple times)
- Include service management best practices (daemon-reload, restart)

## Architecture and Patterns

### System Configuration
- Modify systemd service files in `/etc/systemd/system/`
- Use `sed` for inline file modifications
- Always reload systemd daemon after service file changes
- Set environment variables in service files under `[Service]` section

### Model Management
- Use functions to encapsulate repetitive tasks (e.g., `loadmodel()`)
- Pull models sequentially to avoid resource conflicts
- Support multiple model versions (e.g., standard and large variants)

## Testing Requirements
- Test scripts in a clean environment before deployment
- Verify systemd service modifications don't break existing functionality
- Ensure scripts handle both fresh installations and updates
- Test idempotency (running scripts multiple times should be safe)
- Validate that all specified models can be pulled successfully

## Documentation Expectations
- Comment complex bash operations with clear explanations
- Document prerequisites and system requirements
- Include usage examples where applicable
- Add error messages that guide users toward solutions
- Keep README.md updated with setup instructions when adding new features

## Development Workflow

### Before Making Changes
- Ask clarifying questions before building implementation plans
- Understand the impact on system services and configurations
- Consider backwards compatibility with existing deployments
- Verify that changes work across different Linux distributions (where applicable)

### Code Review Focus Areas
- Security implications of system-level changes
- Error handling and edge cases
- Service availability and restart behavior
- Resource consumption (disk space for models, memory requirements)
- Script idempotency

## Security Considerations
- Validate inputs before using in system commands
- Be cautious with `sudo` operations and system-wide changes
- Review environment variable exposure in service files
- Consider network binding security (e.g., `OLLAMA_HOST=0.0.0.0`)
- Avoid hardcoding sensitive information

## Common Patterns in This Project
1. **Service Configuration**: Modify systemd service files using `sed` with pattern `/\[Service\]/a`
2. **Conditional Updates**: Check if changes are already applied before making modifications
3. **Model Loading**: Iterate through models using the `loadmodel()` function
4. **System Commands**: Use systemctl for service management (daemon-reload, restart)

## When in Doubt
- Ask for clarification on system requirements or deployment scenarios
- Verify assumptions about the target environment
- Request review for changes affecting service availability
- Consult existing patterns in `setup.sh` for consistency
