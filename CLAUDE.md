# {{PROJECT_NAME}} Development Guide

{{PROJECT_DESCRIPTION}}

## Repository Structure

- `src/` - Main application code (see src/README.md for architecture)

## Development Commands

| Command           | Description                  |
| ----------------- | ---------------------------- |
| `npm run build`   | Compile TypeScript           |
| `npm test`        | Run unit tests               |
| `npm run quality` | Run lint, format, type-check |

**IMPORTANT**: Run `npm run quality` and `npm test` after every change.

## Architecture

### Technology Stack

- **Language**: TypeScript 5.8+
- **Testing**: Jest 30+
- **Linting**: ESLint 9+ (flat config)
- **MCP SDK**: @modelcontextprotocol/sdk

---

# Clean Code Charter

## Guiding Principles

| Principle | Test                                  |
| --------- | ------------------------------------- |
| **KISS**  | Can a junior dev understand in 2 min? |
| **YAGNI** | Is this abstraction used 3+ times?    |
| **SRP**   | One concept per function, ≤20 LOC     |
| **DRY**   | Is there duplication to extract?      |

## File Guidelines

- Max 400 lines per file
- No "util" dumping grounds
- PascalCase for types: `MyType.ts`
- camelCase for functions: `myFunction.ts`

## Module Rules

1. Each module owns one domain concept
2. Export only what callers need via `index.ts`
3. No import cycles
4. Prefer composition over inheritance

## Testing

- One happy-path test per public function
- Co-locate tests: `__tests__/myFile.test.ts`

## Forbidden

- `any` types
- `console.log` in production
- Dead code
- Hard-coded secrets

---

## When Unsure

1. Stop and ask a clear question
2. Offer options if helpful
3. Wait for guidance
