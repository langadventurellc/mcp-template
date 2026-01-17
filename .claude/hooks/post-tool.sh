#!/bin/bash
# Post-tool hook: Runs after file modifications
#
# This hook is triggered after Edit, Write, MultiEdit, and NotebookEdit tools.
# Use this to run quality checks and ensure code standards are maintained.
#
# Exit codes:
# - 0: Success, continue normally
# - 1: Error, halt execution
# - 2: Warning, suggest fixes but allow continuation

# Navigate to repository root for consistent path handling
cd "$(git rev-parse --show-toplevel)" || exit 1

echo "Running post-edit quality checks..."

# Run linting
echo "Running lint..."
LINT_OUTPUT=$(npm run lint 2>&1)
if [ $? -ne 0 ]; then
    echo "Lint issues detected - consider fixing before continuing" >&2
    echo "$LINT_OUTPUT" | grep -E "(error|warning)" >&2
    exit 2
fi
echo "Lint passed"

# Run type checking
echo "Running type-check..."
TYPE_OUTPUT=$(npm run type-check 2>&1)
if [ $? -ne 0 ]; then
    echo "Type errors detected - consider fixing before continuing" >&2
    echo "$TYPE_OUTPUT" | grep -E "(error|TS[0-9]+)" >&2
    exit 2
fi
echo "Type-check passed"

echo "All quality checks passed"
exit 0
