#!/usr/bin/env bash
#
# MCP Server Template Initialization Script
# Replaces placeholders and sets up the development environment
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  MCP Server Template Initialization${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Prompt for values with defaults
prompt() {
    local var_name="$1"
    local prompt_text="$2"
    local default="$3"
    local value

    if [[ -n "$default" ]]; then
        echo -en "${GREEN}$prompt_text${NC} [${YELLOW}$default${NC}]: "
    else
        echo -en "${GREEN}$prompt_text${NC}: "
    fi
    read -r value

    if [[ -z "$value" && -n "$default" ]]; then
        value="$default"
    fi

    eval "$var_name=\"$value\""
}

# Gather project information
echo -e "${BLUE}Enter your project details:${NC}"
echo ""

prompt PROJECT_NAME "Package name (e.g., my-mcp-server)" ""
prompt PROJECT_DESCRIPTION "One-line description" "An MCP server"
prompt AUTHOR_NAME "Author name" ""
prompt AUTHOR_EMAIL "Author email" ""
prompt GITHUB_ORG "GitHub org/username" ""
prompt GITHUB_REPO "Repository name" "$PROJECT_NAME"
prompt NPM_SCOPE "NPM scope (e.g., @myorg, or leave empty for none)" ""

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Configuration Summary${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "  Project name:  ${YELLOW}$PROJECT_NAME${NC}"
echo -e "  Description:   ${YELLOW}$PROJECT_DESCRIPTION${NC}"
echo -e "  Author:        ${YELLOW}$AUTHOR_NAME <$AUTHOR_EMAIL>${NC}"
echo -e "  GitHub:        ${YELLOW}$GITHUB_ORG/$GITHUB_REPO${NC}"
echo -e "  NPM scope:     ${YELLOW}${NPM_SCOPE:-none}${NC}"
echo ""

echo -en "Proceed with initialization? [Y/n]: "
read -r confirm
if [[ "$confirm" =~ ^[Nn] ]]; then
    echo -e "${RED}Initialization cancelled.${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}Replacing placeholders...${NC}"

# Find all files to process (excluding node_modules, .git, and binary files)
find_files() {
    find . -type f \
        ! -path "./node_modules/*" \
        ! -path "./.git/*" \
        ! -path "./dist/*" \
        ! -name "*.png" \
        ! -name "*.jpg" \
        ! -name "*.ico" \
        ! -name "init.sh" \
        -print0
}

# Replace placeholders in files
replace_placeholder() {
    local placeholder="$1"
    local value="$2"

    if [[ -z "$value" ]]; then
        return
    fi

    # Escape special characters for sed
    local escaped_value
    escaped_value=$(printf '%s\n' "$value" | sed -e 's/[&/\]/\\&/g')

    while IFS= read -r -d '' file; do
        if file "$file" | grep -q text; then
            if grep -q "$placeholder" "$file" 2>/dev/null; then
                sed -i '' "s|$placeholder|$escaped_value|g" "$file" 2>/dev/null || \
                sed -i "s|$placeholder|$escaped_value|g" "$file" 2>/dev/null || true
            fi
        fi
    done < <(find_files)
}

replace_placeholder "{{PROJECT_NAME}}" "$PROJECT_NAME"
echo -e "  ✓ PROJECT_NAME"

replace_placeholder "{{PROJECT_DESCRIPTION}}" "$PROJECT_DESCRIPTION"
echo -e "  ✓ PROJECT_DESCRIPTION"

replace_placeholder "{{AUTHOR_NAME}}" "$AUTHOR_NAME"
echo -e "  ✓ AUTHOR_NAME"

replace_placeholder "{{AUTHOR_EMAIL}}" "$AUTHOR_EMAIL"
echo -e "  ✓ AUTHOR_EMAIL"

replace_placeholder "{{GITHUB_ORG}}" "$GITHUB_ORG"
echo -e "  ✓ GITHUB_ORG"

replace_placeholder "{{GITHUB_REPO}}" "$GITHUB_REPO"
echo -e "  ✓ GITHUB_REPO"

replace_placeholder "{{NPM_SCOPE}}" "$NPM_SCOPE"
echo -e "  ✓ NPM_SCOPE"

CURRENT_YEAR=$(date +%Y)
replace_placeholder "{{YEAR}}" "$CURRENT_YEAR"
echo -e "  ✓ YEAR ($CURRENT_YEAR)"

echo ""
echo -e "${BLUE}Installing dependencies...${NC}"
npm install

echo ""
echo -e "${BLUE}Setting up Husky git hooks...${NC}"
npm run prepare

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Initialization complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "Next steps:"
echo -e "  1. Run ${YELLOW}npm run build${NC} to compile TypeScript"
echo -e "  2. Run ${YELLOW}npm test${NC} to verify setup"
echo -e "  3. Start building your MCP server in ${YELLOW}src/server.ts${NC}"
echo ""
echo -e "You can safely delete this init.sh script now."
echo ""
