# {{PROJECT_NAME}}

{{PROJECT_DESCRIPTION}}

## Quick Start

### Option A: Automated Setup (Recommended)

Run the initialization script to configure your project interactively:

```bash
./init.sh
```

This will prompt you for project details, replace all placeholders, install dependencies, and set up git hooks.

### Option B: Manual Setup

If you prefer manual configuration:

1. **Replace placeholders** throughout the codebase:

   | Placeholder               | Description          | Example                |
   | ------------------------- | -------------------- | ---------------------- |
   | `{{PROJECT_NAME}}`        | Package name         | `my-mcp-server`        |
   | `{{PROJECT_DESCRIPTION}}` | One-line description | `An MCP server for...` |
   | `{{AUTHOR_NAME}}`         | Your name            | `Jane Doe`             |
   | `{{AUTHOR_EMAIL}}`        | Your email           | `jane@example.com`     |
   | `{{GITHUB_ORG}}`          | GitHub org/user      | `janedoe`              |
   | `{{GITHUB_REPO}}`         | Repository name      | `my-mcp-server`        |
   | `{{NPM_SCOPE}}`           | NPM scope            | `@janedoe`             |

2. **Install dependencies and set up hooks:**

   ```bash
   npm install
   npm run prepare  # Initialize Husky
   ```

## Development

### Commands

| Command              | Description              |
| -------------------- | ------------------------ |
| `npm run build`      | Compile TypeScript       |
| `npm run dev`        | Watch mode compilation   |
| `npm test`           | Run unit tests           |
| `npm run test:e2e`   | Run end-to-end tests     |
| `npm run lint`       | Run ESLint               |
| `npm run format`     | Format with Prettier     |
| `npm run type-check` | TypeScript type checking |
| `npm run quality`    | Run all quality checks   |

### Project Structure

See [src/README.md](src/README.md) for detailed architecture documentation.

## Configuration

### MCP Client Setup

Add to your MCP client configuration:

```json
{
  "mcpServers": {
    "{{PROJECT_NAME}}": {
      "command": "node",
      "args": ["path/to/dist/server.js"]
    }
  }
}
```

## Publishing

This template includes GitHub Actions for automated NPM publishing:

- Push a tag like `v1.0.0` to publish to `latest`
- Push a tag like `v1.0.0-beta.1` to publish to `beta`

Requires `NPM_TOKEN` secret in GitHub repository settings.

## License

MIT - see [LICENSE](LICENSE)
