#!/bin/bash
# Pre-tool hook: Runs before file modifications
#
# This hook is triggered before Edit, Write, MultiEdit, and NotebookEdit tools.
# Use this to add quality gates or checks before allowing file changes.
#
# Customize this script to add your own pre-edit validations:
# - Ensure tests pass before editing
# - Check for uncommitted changes
# - Validate environment state
# - etc.

# Navigate to repository root for consistent path handling
cd "$(git rev-parse --show-toplevel)" || exit 1

# Example: Uncomment to require tests to pass before edits
# echo "Running tests before edit..."
# if ! npm run test; then
#     echo "Tests failed - aborting edit" >&2
#     exit 2
# fi

# Allow the edit to proceed
exit 0
