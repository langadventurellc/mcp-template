# Source Architecture

This directory contains the source code for your MCP server, organized using clean architecture principles.

## Folder Structure

```
src/
├── server.ts            # Entry point: MCP server setup + CLI parsing
├── configuration/       # Server configuration types and interfaces
├── models/              # Domain entities and data structures
├── tools/               # MCP tool definitions and handlers
├── services/            # Business logic layer
├── repositories/        # Data access layer (Ports & Adapters)
├── validation/          # Input validation and error handling
├── prompts/             # MCP prompt definitions and rendering
├── utils/               # Pure utility functions
└── __tests__/           # Test files
    └── e2e/             # End-to-end tests
```

## Folder Descriptions

### `configuration/`

Server configuration types and interfaces. Define your config schema here.

**Example contents:**

- `ServerConfig.ts` - Main configuration interface
- `Environment.ts` - Environment-specific settings

### `models/`

Domain entities and data structures. These are your core business objects.

**Example contents:**

- `User.ts` - User entity type
- `UserStatus.ts` - Status enum
- `isActive.ts` - Type guard functions

### `tools/`

MCP tool definitions with their handlers. Each tool should have its schema and handler.

**Example contents:**

- `createUserTool.ts` - Tool definition and handler
- `index.ts` - Barrel export of all tools

### `services/`

Business logic layer. Services orchestrate operations and contain domain logic.

**Example contents:**

- `UserService.ts` - Service interface
- `local/UserService.ts` - Local implementation

### `repositories/`

Data access abstraction following Ports & Adapters pattern. Define interfaces and implementations.

**Example contents:**

- `Repository.ts` - Repository interface
- `local/LocalRepository.ts` - File-based implementation

### `validation/`

Input validation utilities and error types.

**Example contents:**

- `ValidationError.ts` - Custom error class
- `validateInput.ts` - Validation functions

### `prompts/`

MCP prompt definitions for AI agent guidance.

**Example contents:**

- `MyPrompt.ts` - Prompt template
- `PromptManager.ts` - Prompt registration

### `utils/`

Pure utility functions with single responsibilities. Keep these focused and testable.

**Example contents:**

- `generateId.ts` - ID generation
- `formatDate.ts` - Date formatting

## Naming Conventions

| Type             | Convention  | Example              |
| ---------------- | ----------- | -------------------- |
| Types/Interfaces | PascalCase  | `ServerConfig.ts`    |
| Functions/Utils  | camelCase   | `generateId.ts`      |
| Constants        | UPPER_SNAKE | `DEFAULT_TIMEOUT`    |
| Test files       | `*.test.ts` | `generateId.test.ts` |
| E2E tests        | `*.e2e.test.ts` | `server.e2e.test.ts` |

## Architectural Principles

1. **Barrel Exports** - Each folder has `index.ts` exporting public API
2. **Co-located Tests** - Unit tests in `__tests__/` within each module
3. **Separation of Concerns** - tools -> services -> repositories
4. **Interface-First** - Define interfaces before implementations
5. **Single Responsibility** - Each file owns one concept

## Adding New Components

### Adding a Tool

1. Create `tools/myTool.ts` with schema and handler
2. Export from `tools/index.ts`
3. Register in `server.ts`

### Adding a Service

1. Define interface in `services/MyService.ts`
2. Create implementation in `services/local/MyService.ts`
3. Export from `services/index.ts`

### Adding a Repository

1. Define interface in `repositories/MyRepository.ts`
2. Create implementation in `repositories/local/MyRepository.ts`
3. Export from `repositories/index.ts`

### Adding a Prompt

1. Create `prompts/MyPrompt.ts` with prompt definition
2. Export from `prompts/index.ts`
3. Register in `server.ts`

### Adding Tests

1. Unit tests: `folder/__tests__/myFile.test.ts`
2. E2E tests: `__tests__/e2e/myFeature.e2e.test.ts`
