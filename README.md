# LangChain Agent-to-Agent Communication with MCP

A simple, minimal setup for LangChain agent-to-agent communication using Model Context Protocol (MCP) and LiteLLM proxy.

## Quick Start with Docker (Recommended)

### Prerequisites
- Docker and Docker Compose installed
- Docker permissions configured (see Troubleshooting below if you get permission errors)

### Steps

1. **Configure environment:**
   ```bash
   cp .env.example .env
   ```
   
   Edit `.env` with your actual values:
   ```
   LITELLM_BASE_URL=https://your-llm-provider.com
   LITELLM_API_KEY=sk-your-key-here
   LITELLM_MODEL=your-model-name
   ```

2. **Build and run with Docker Compose:**
   ```bash
   docker compose up --build
   ```

3. **Or build and run with Docker directly:**
   ```bash
   # Build the image
   docker build -t langchain-mcp-agent .

   # Run the container
   docker run --env-file .env langchain-mcp-agent
   ```

4. **Run in detached mode (background):**
   ```bash
   docker compose up -d
   ```

5. **View logs:**
   ```bash
   docker compose logs -f
   ```

6. **Stop the container:**
   ```bash
   docker compose down
   ```

### Docker Commands Quick Reference

```bash
# Build and run (recommended) - Use 'docker compose' (space, not hyphen)
docker compose up --build

# Run in background
docker compose up -d

# View logs
docker compose logs -f

# Stop container
docker compose down

# Rebuild without cache
docker compose build --no-cache

# Execute command in running container
docker compose exec langchain-mcp bash

# Using Docker directly (without compose)
docker build -t langchain-mcp-agent .
docker run --env-file .env langchain-mcp-agent

# Run with custom environment variables
docker run -e LITELLM_BASE_URL=https://your-llm-provider.com \
           -e LITELLM_API_KEY=sk-your-key \
           -e LITELLM_MODEL=your-model-name \
           langchain-mcp-agent
```

**Note:** Use `docker compose` (with a space) instead of `docker-compose` (with a hyphen). The hyphenated version is the legacy v1 tool which may have compatibility issues.

## Local Setup (Without Docker)

1. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

2. **Configure environment:**
   Copy `.env.example` to `.env` and update with your LiteLLM credentials:
   ```bash
   cp .env.example .env
   ```
   
   Edit `.env` with your actual values:
   ```
   LITELLM_BASE_URL=https://your-llm-provider.com
   LITELLM_API_KEY=sk-your-key-here
   LITELLM_MODEL=your-model-name
   ```

3. **Run the agent communication example:**
   ```bash
   python agent_communication.py
   ```

## Architecture

- **`mcp_server.py`**: Simple MCP server with math tools (add, multiply, subtract, divide)
- **`agent_communication.py`**: Main script demonstrating agent-to-agent communication using MCP tools
- **`Dockerfile`**: Docker image configuration
- **`docker-compose.yml`**: Docker Compose configuration for easy orchestration
- **`.env.example`**: Environment variable template

## How It Works

1. **MCP Server**: Provides tools (math operations) via stdio transport
2. **MultiServerMCPClient**: Connects to MCP servers and exposes tools to LangChain
3. **LangChain Agents**: Use MCP tools to solve problems and communicate
4. **LiteLLM Proxy**: Handles LLM API calls through the configured proxy

## Extending

To add more agents or MCP servers:

1. Create additional MCP servers (see `mcp_server.py` as example)
2. Add them to the `MultiServerMCPClient` configuration in `agent_communication.py`
3. Create new agents with different system prompts and tools

## Troubleshooting

### Permission Denied Error

If you get `permission denied while trying to connect to the Docker daemon socket`, you have two options:

**Option 1: Use sudo (quick fix)**
```bash
sudo docker compose up --build
```

**Option 2: Add user to docker group (recommended)**
```bash
sudo usermod -aG docker $USER
# Log out and log back in, or run:
newgrp docker
# Then verify:
docker compose version
```

### Using docker-compose vs docker compose

- ✅ Use `docker compose` (space) - This is Docker Compose v2 (recommended)
- ❌ Avoid `docker-compose` (hyphen) - This is the legacy v1 tool

### Version Warning

If you see a warning about the `version` field being obsolete, it's been removed from the docker-compose.yml file. This is normal for Docker Compose v2.

## References

- [LangChain MCP Documentation](https://docs.langchain.com/oss/python/langchain/mcp)
- [FastMCP Library](https://github.com/jlowin/fastmcp)

