# HIEofOne Local Testing Environment

This is a **simplified local testing setup** that bypasses complex authentication, email verification, and external API requirements. Perfect for development and testing without needing API keys or email services.

## 🎯 What's Simplified

### ✅ **Bypassed Features**
- **Email Verification**: No email sending required
- **Complex Authentication**: Simple username/password login
- **External API Keys**: Mock AI responses instead
- **WebAuthn/Passkeys**: Standard form-based login
- **GNAP Authorization**: Simplified for local testing

### 🔑 **Default Credentials**
- **Email**: `test@localhost`
- **Password**: `test123`

## 🚀 Quick Start

### 1. Check Prerequisites
```bash
./start-simple.sh check
```

### 2. Start the Environment
```bash
./start-simple.sh start
```

### 3. Access the Services

| Service | URL | Description |
|---------|-----|-------------|
| **CouchDB** | http://localhost:5984 | Database management |
| **MAIA Vue AI** | http://localhost:3001 | AI chat interface |
| **NOSH3** | http://localhost:4000 | Healthcare system |
| **Trustee Community** | http://localhost:3000 | Patient data management |
| **Trustee Proxy** | http://localhost:4001 | Proxy service |
| **Vue3-GNAP** | http://localhost:3002 | GNAP component |

## 🔧 How It Works

### Authentication Flow
1. **Trustee Community**: Uses `/api/auth/simple-login` endpoint
2. **NOSH3**: Uses simplified authentication in `auth-simple.mjs`
3. **MAIA**: Uses mock AI responses in `server-simple.js`

### Mock AI Responses
The MAIA system uses mock responses instead of real AI APIs:
- Personal AI: `[Personal AI] I understand you're asking about: "..."`
- Anthropic: `[Anthropic Claude] Here's my response to: "..."`
- Gemini: `[Google Gemini] I can help with: "..."`
- DeepSeek: `[DeepSeek R1] My analysis of: "..."`

## 📁 File Structure

```
HIEofOne-local-dev/
├── docker-compose.simple.yml          # Simplified Docker setup
├── start-simple.sh                   # Simplified startup script
├── MAIA-vue-ai-example/
│   ├── server-simple.js              # Mock AI server
│   └── Dockerfile.simple             # Simplified Dockerfile
├── nosh3/
│   ├── auth-simple.mjs               # Simplified authentication
│   └── Dockerfile.simple             # Simplified Dockerfile
├── Trustee-Community/
│   ├── pages/api/auth/simple-login.ts # Simple login endpoint
│   ├── components/SimpleLogin.tsx    # Simple login component
│   └── Dockerfile.simple             # Simplified Dockerfile
└── ... (other components)
```

## 🛠️ Development Workflow

### Phase 1: Basic Integration ✅
1. Start all services with simplified authentication
2. Verify each service is accessible
3. Test basic login functionality

### Phase 2: NOSH3 → MAIA Integration 🔄
1. Add a "Launch MAIA" button in NOSH3
2. Pass user context from NOSH3 to MAIA
3. Test the integration flow

### Phase 3: Chat → Database Integration 📝
1. Save MAIA chat transcripts to NOSH3 database
2. Create encounter notes from chat sessions
3. Test end-to-end workflow

## 🔍 Troubleshooting

### Common Issues

**Port Conflicts**
```bash
# Check what's using the ports
lsof -i :3000 -i :3001 -i :4000 -i :5984
```

**Docker Issues**
```bash
# Restart Docker
docker system prune -a
./start-simple.sh restart
```

**Database Issues**
```bash
# Reset CouchDB data
rm -rf couchdb_data couchdb_config
./start-simple.sh start
```

### Useful Commands

```bash
# View all logs
./start-simple.sh logs

# View specific service logs
./start-simple.sh logs maia-vue-ai

# Check service status
./start-simple.sh status

# Stop all services
./start-simple.sh stop
```

## 🔄 Next Steps

### Integration Testing
1. **Test NOSH3 Login**: Use `test@localhost` / `test123`
2. **Test MAIA Chat**: Send messages and verify mock responses
3. **Test Trustee**: Verify simplified authentication works
4. **Test Cross-Service Communication**: Ensure services can talk to each other

### Adding Features
1. **NOSH3 → MAIA Button**: Add launch button in NOSH3 dashboard
2. **Context Passing**: Pass patient data from NOSH3 to MAIA
3. **Chat Saving**: Save MAIA conversations to NOSH3 database
4. **Encounter Notes**: Convert chat sessions to medical encounters

## 📝 Notes

- **No External Dependencies**: All AI responses are mocked
- **No Email Required**: Authentication bypasses email verification
- **Single User Mode**: Designed for single-user local testing
- **Development Focus**: Optimized for development and testing
- **Production Ready**: Can be extended with real APIs later

## 🚨 Important

This is a **development/testing environment**. Do not use these simplified credentials or mock responses in production. The production setup requires proper authentication, API keys, and email verification.

## 📞 Support

If you encounter issues:
1. Check the logs: `./start-simple.sh logs`
2. Restart services: `./start-simple.sh restart`
3. Reset environment: `./start-simple.sh stop && ./start-simple.sh start`

---

**Ready to test? Run `./start-simple.sh start` and begin your local development!** 🚀 