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