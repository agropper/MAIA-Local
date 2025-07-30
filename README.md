# HIEofOne Local Development Environment

This repository contains an integrated Docker setup for all HIEofOne components, allowing you to run the entire system locally.

## Components

- **MAIA-vue-ai-example**: AI-powered chat interface with multiple AI providers
- **nosh3**: Healthcare information system
- **Trustee-Community**: Patient data management and authorization
- **Trustee-Proxy**: Proxy service for data access
- **vue3-gnap**: GNAP authorization component

## Prerequisites

- Docker and Docker Compose installed
- At least 8GB RAM available
- Ports 80, 443, 8080 available

## Quick Start

### 1. Environment Setup

All `.env` files have been created with default values. Update them with your actual API keys and configuration:

- `MAIA-vue-ai-example/.env` - AI provider API keys
- `nosh3/.env` - NOSH3 configuration
- `Trustee-Community/.env` - Database and email settings
- `Trustee-Proxy/.env` - Proxy configuration
- `vue3-gnap/.env` - GNAP settings

### 2. Production Deployment

```bash
# Build and start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop all services
docker-compose down
```

### 3. Development Mode

```bash
# Start development environment with hot reloading
docker-compose -f docker-compose.dev.yml up -d

# View logs
docker-compose -f docker-compose.dev.yml logs -f

# Stop development environment
docker-compose -f docker-compose.dev.yml down
```

## Access Points

Once running, you can access the services at:

- **Traefik Dashboard**: http://localhost:8080
- **MAIA Vue AI**: http://maia.localhost
- **NOSH3**: http://nosh.localhost
- **Trustee Community**: http://trustee.localhost
- **Trustee Proxy**: http://proxy.localhost
- **Vue3-GNAP**: http://gnap.localhost
- **CouchDB**: http://db.localhost

## Service URLs

### Production URLs
- MAIA Vue AI: `http://maia.localhost`
- NOSH3: `http://nosh.localhost`
- Trustee Community: `http://trustee.localhost`
- Trustee Proxy: `http://proxy.localhost`
- Vue3-GNAP: `http://gnap.localhost`
- CouchDB: `http://db.localhost`

### Development URLs
- MAIA Vue AI: `http://maia.localhost:3001`
- NOSH3: `http://nosh.localhost:4000`
- Trustee Community: `http://trustee.localhost:3000`
- Trustee Proxy: `http://proxy.localhost:4000`
- Vue3-GNAP: `http://gnap.localhost:3000`

## Configuration

### Environment Variables

Each component has its own `.env` file with specific configuration:

#### MAIA-vue-ai-example/.env
```env
VITE_API_BASE_URL=http://localhost:3001/api
PORT=3001
OPENAI_API_KEY=your-openai-key
ANTHROPIC_API_KEY=your-anthropic-key
DEEPSEEK_API_KEY=your-deepseek-key
GEMINI_API_KEY=your-gemini-key
DIGITALOCEAN_PERSONAL_API_KEY=your-do-key
DIGITALOCEAN_GENAI_ENDPOINT=https://vzfujeetn2dkj4d5awhvvibo.agents.do-ai.run/api/v1
```

#### Trustee-Community/.env
```env
COUCHDB_USER=admin
COUCHDB_PASSWORD=adminpassword
DOMAIN=http://localhost:3000
APP_URL=http://localhost:3000
MAIL_TYPE=smtp
FROM_EMAIL=support@hieofone.com
SMTP_HOST=smtp.mailtrap.io
SMTP_PORT=2525
SMTP_USER=user
SMTP_PASSWORD=password
SENDGRID_API_KEY=your-sendgrid-key
AWS_ACCESS_KEY=your-aws-access-key
AWS_SECRET_ACCESS_KEY=your-aws-secret
AWS_REGION=us-east-1
ADMIN_EMAIL=admin@hieofone.com
ENCRYPTION_SECRET=your-encryption-secret
SECRET_COOKIE_PASSWORD=your-cookie-secret
NODE_ENV=development
```

## Knowledge Base Management

MAIA supports comprehensive knowledge base management through the DigitalOcean GenAI API. This allows you to create, manage, and connect knowledge bases to your AI agents.

### Overview

Knowledge bases in MAIA are powered by DigitalOcean's GenAI platform and provide:
- **Document Storage**: Upload and store patient documents, medical records, and other healthcare data
- **Semantic Search**: AI-powered search through uploaded documents
- **Agent Integration**: Connect knowledge bases to AI agents for context-aware responses
- **Multi-format Support**: PDF, text, and other document formats

### Accessing Knowledge Base Management

1. **Open MAIA**: Navigate to `http://maia.localhost` (or your configured domain)
2. **Agent Badge**: Look for the agent status badge at the top of the chat interface
3. **Manage Agent**: Click the "Manage Agent" button in the agent badge
4. **Knowledge Base Tab**: The dialog will show available knowledge bases and connection status

### Managing Knowledge Bases

#### Viewing Available Knowledge Bases

The Manage Agent dialog displays:
- **Current Knowledge Base**: The KB currently connected to your agent
- **Available Knowledge Bases**: All KBs in your DigitalOcean account
- **Connection Status**: Visual indicators showing which KBs are connected
- **KB Details**: Name, creation date, and other metadata

#### Connecting a Knowledge Base

1. **Select KB**: Click on an available knowledge base in the list
2. **Confirm Action**: A confirmation dialog will appear
3. **Connect**: Click "OK" to connect the KB to your agent
4. **Verification**: The UI will update to show the new connection

#### Disconnecting a Knowledge Base

1. **Select Connected KB**: Click on a currently connected knowledge base
2. **Confirm Detach**: A confirmation dialog will appear
3. **Detach**: Click "OK" to disconnect the KB from your agent
4. **Verification**: The UI will update to show the KB is no longer connected

#### Creating New Knowledge Bases

1. **Upload Documents**: Use the paper clip button in the chat interface to upload documents
2. **Create KB**: In the Manage Agent dialog, click "Create New Knowledge Base"
3. **Select Documents**: Choose from your uploaded documents
4. **Name KB**: Provide a descriptive name for your knowledge base
5. **Create**: The system will create the KB and index your documents

### API Endpoints

MAIA provides several API endpoints for knowledge base management:

#### Get Current Agent and KB Status
```bash
GET /api/current-agent
```

#### List All Knowledge Bases
```bash
GET /api/knowledge-bases
```

#### Connect Knowledge Base to Agent
```bash
POST /api/agents/{agent_uuid}/knowledge_bases/{kb_uuid}
```

#### Disconnect Knowledge Base from Agent
```bash
DELETE /api/agents/{agent_uuid}/knowledge_bases/{kb_uuid}
```

#### Create New Knowledge Base
```bash
POST /api/knowledge-bases
Content-Type: application/json
{
  "name": "My Knowledge Base",
  "document_uuids": ["doc-uuid-1", "doc-uuid-2"]
}
```

### DigitalOcean API Integration

MAIA integrates with DigitalOcean's GenAI API for knowledge base operations:

#### Supported Operations
- ✅ **List Knowledge Bases**: Retrieve all KBs in your account
- ✅ **Create Knowledge Base**: Create new KBs with uploaded documents
- ✅ **Connect KB to Agent**: Attach KBs to AI agents
- ✅ **Disconnect KB from Agent**: Remove KBs from agents
- ✅ **Agent Status**: View current agent and connected KBs

#### API Endpoints Used
- `GET /v2/gen-ai/knowledge_bases` - List all KBs
- `POST /v2/gen-ai/knowledge_bases` - Create new KB
- `POST /v2/gen-ai/agents/{agent_uuid}/knowledge_bases/{kb_uuid}` - Connect KB
- `DELETE /v2/gen-ai/agents/{agent_uuid}/knowledge_bases/{kb_uuid}` - Disconnect KB
- `GET /v2/gen-ai/agents/{agent_uuid}` - Get agent details

### Troubleshooting Knowledge Base Issues

#### Common Issues

1. **KB Not Connecting**
   - Verify your DigitalOcean API token has correct permissions
   - Check that the KB UUID is valid
   - Ensure the agent is running and accessible

2. **Documents Not Indexing**
   - Wait for indexing to complete (can take several minutes)
   - Check document format is supported (PDF, text, etc.)
   - Verify document size is within limits

3. **Agent Not Responding with KB Context**
   - Confirm the KB is properly connected to the agent
   - Check that documents have been indexed successfully
   - Verify the agent is using the correct model for KB retrieval

#### Verification Commands

Test knowledge base connectivity:
```bash
# Check current agent status
curl -s http://localhost:3001/api/current-agent | jq '.agent.knowledgeBases'

# List all knowledge bases
curl -s http://localhost:3001/api/knowledge-bases | jq '.[0:3]'

# Test KB connection
curl -X POST "http://localhost:3001/api/agents/{agent_uuid}/knowledge_bases/{kb_uuid}" | jq '.success'
```

### Best Practices

1. **Naming Convention**: Use descriptive names for knowledge bases (e.g., "Patient-001-Medical-Records")
2. **Document Organization**: Group related documents in the same KB
3. **Regular Updates**: Periodically update KBs with new information
4. **Testing**: Always test KB connections before using in production
5. **Backup**: Keep copies of important documents outside the system

### Security Considerations

- **Data Privacy**: Knowledge bases may contain sensitive patient information
- **Access Control**: Ensure only authorized users can manage KBs
- **Audit Trail**: Monitor KB connections and changes
- **Encryption**: Verify data is encrypted in transit and at rest

## Troubleshooting

### Common Issues

1. **Port conflicts**: Ensure ports 80, 443, 8080 are available
2. **Memory issues**: Increase Docker memory allocation to at least 8GB
3. **Build failures**: Check that all `.env` files exist and have valid values
4. **Database connection**: Ensure CouchDB is running before starting dependent services

### Useful Commands

```bash
# Check service status
docker-compose ps

# View logs for specific service
docker-compose logs -f [service-name]

# Rebuild a specific service
docker-compose build [service-name]

# Restart a specific service
docker-compose restart [service-name]

# Access container shell
docker-compose exec [service-name] sh

# Clean up volumes (WARNING: deletes all data)
docker-compose down -v
```

### Development Tips

1. **Hot Reloading**: Use `docker-compose.dev.yml` for development with live code changes
2. **Debugging**: Check logs with `docker-compose logs -f [service-name]`
3. **Database Access**: CouchDB is available at `http://db.localhost:5984`
4. **API Testing**: Use the Traefik dashboard at `http://localhost:8080` to monitor traffic

## Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Traefik       │    │   CouchDB       │    │   Watchtower    │
│   Router        │    │   Database      │    │   Auto Updates  │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
         ┌───────────────────────┼───────────────────────┐
         │                       │                       │
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  MAIA Vue AI    │    │  Trustee        │    │  Trustee        │
│  Chat Interface  │    │  Community      │    │  Proxy          │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                    ┌─────────────────┐
                    │   NOSH3         │
                    │   Healthcare    │
                    │   System        │
                    └─────────────────┘
```

## Contributing

1. Make changes to the source code
2. Rebuild the affected service: `docker-compose build [service-name]`
3. Restart the service: `docker-compose restart [service-name]`
4. Test your changes

## License

This project is part of the HIEofOne ecosystem. See individual component licenses for details. 