#!/usr/bin/env node

import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";
import { Command } from "commander";

// Parse command line arguments
const program = new Command();
program
  .name("{{PROJECT_NAME}}")
  .description("{{PROJECT_DESCRIPTION}}")
  .version("1.0.0")
  .option("--example <value>", "Example option", "default");

program.parse();

const _options = program.opts<{ example: string }>();

// Create the MCP server
const server = new Server(
  {
    name: "{{PROJECT_NAME}}",
    version: "1.0.0",
    description: "{{PROJECT_DESCRIPTION}}",
  },
  {
    capabilities: {
      tools: {},
      // Uncomment to enable prompts:
      // prompts: {},
    },
  },
);

// Register tool list handler
server.setRequestHandler(ListToolsRequestSchema, () => {
  // TODO: Add your tools here
  // Example:
  // return {
  //   tools: [
  //     {
  //       name: "my_tool",
  //       description: "Description of my tool",
  //       inputSchema: { type: "object", properties: {}, required: [] },
  //     },
  //   ],
  // };
  return { tools: [] };
});

// Register tool call handler
server.setRequestHandler(CallToolRequestSchema, (request) => {
  const { name: toolName, arguments: args } = request.params;
  void args; // Placeholder for tool arguments - remove when implementing tools

  // TODO: Handle your tools here
  // Example:
  // switch (toolName) {
  //   case "my_tool":
  //     return handleMyTool(args);
  //   default:
  //     throw new Error(`Unknown tool: ${toolName}`);
  // }

  throw new Error(`Unknown tool: ${toolName}`);
});

// Start the server
async function runServer() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
}

runServer().catch((error) => {
  console.error("Server error:", error);
  process.exit(1);
});
