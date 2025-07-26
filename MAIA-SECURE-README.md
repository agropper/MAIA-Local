# MAIA Secure Local Development

## Overview
MAIA (Medical AI Assistant) is a secure, single-patient demonstration system that integrates with DigitalOcean Agent Platform for AI capabilities while running locally for development and privacy.

## 🎯 Current Functionality Summary

### ✅ **Core Features Implemented**

#### **1. Multi-AI Provider Integration**
- **Personal AI**: DigitalOcean Agent Platform with RAG capabilities
- **Anthropic Claude**: Direct API integration with context handling
- **Google Gemini**: Direct API integration with chat history
- **DeepSeek R1**: Direct API integration with context support
- **Fallback System**: Mock responses when API keys are unavailable

#### **2. File Upload & Context System**
- **Paperclip Button**: Uploads `.md`, `.pdf`, `.txt`, `.json` files
- **File Badges**: Display inline with chat showing file size and view button
- **Context Integration**: 
  - **Personal Chat**: RAG access to DigitalOcean Knowledge Base
  - **Frontier LLMs**: Chat transcript + uploaded file context
  - **Transcript Files**: Load conversation history for all AIs
  - **Timeline Files**: Load patient data for Personal Chat RAG

#### **3. Chat Interface Features**
- **Clean Console Logging**: Shows token counts, context size, response times
- **Proper AI Labeling**: Each response correctly labeled with AI provider name
- **File Viewing**: Eye icon to view uploaded file contents
- **Message Editing**: Edit previous messages in chat
- **Transcript Export**: Save conversation as markdown file

#### **4. Security & Configuration**
- **Single Patient Mode**: Secure for personal demo use
- **Environment Variables**: Proper API key management
- **Docker Security**: Non-root user, security headers, rate limiting
- **CORS Configuration**: Proper cross-origin handling

#### **5. Development Features**
- **Hot Reload**: Frontend changes reflect immediately
- **Docker Compose**: Multi-container orchestration
- **Health Checks**: Container monitoring and restart
- **Clean Logging**: Essential information only in console

### 🔧 **Technical Implementation**

#### **Backend (`server-secure.js`)**
```javascript
// AI Provider Endpoints
POST /api/personal-chat    // DigitalOcean Agent Platform
POST /api/anthropic-chat   // Anthropic Claude API
POST /api/gemini-chat      // Google Gemini API  
POST /api/deepseek-r1-chat // DeepSeek R1 API

// Features
- Token counting and context size calculation
- Response time tracking
- Proper error handling and fallbacks
- File context integration
- Clean chat history management
```

#### **Frontend (Vue.js + Quasar)**
```typescript
// Key Components
- ChatArea.vue: Main chat interface with file badges
- ChatPrompt.vue: Input handling and AI selection
- FileBadge.vue: File display with view functionality
- useQuery.ts: AI communication with logging
- useChatState.ts: Application state management
- useAuthHandling.ts: File upload and authentication
```

#### **File Upload System**
```typescript
// Supported File Types
- transcript.md: Conversation history for all AIs
- timeline.json: Patient data for Personal Chat RAG
- *.pdf: Text extraction for context
- *.md: Markdown parsing for context
- *.txt: Plain text for context
- *.json: JSON data for context
```

### 📊 **Console Logging Features**
```
🤖 Personal AI: 1072 tokens, 4.15KB context, 1 files
✅ Personal AI response: 9257ms

🤖 Anthropic: 1073 tokens, 4.15KB context, 1 files  
✅ Anthropic response: 959ms

📁 File upload: transcript.md (transcript) - 4KB
```

### 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Local Development                       │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐      │
│  │   MAIA      │  │   CouchDB   │  │   NOSH3     │      │
│  │ Frontend    │  │   (Data)    │  │(Healthcare) │      │
│  │ + Backend   │  │             │  │             │      │
│  │   :3001     │  │   :5984     │  │   :4000     │      │
│  └─────────────┘  └─────────────┘  └─────────────┘      │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                 DigitalOcean Cloud                         │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────┐   │
│  │           Agent Platform                           │   │
│  │  • Personal AI Agent                              │   │
│  │  • Knowledge Base                                 │   │
│  │  • Model Management                               │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

## 🚀 Quick Start

### 1. Prerequisites

- Docker and Docker Compose installed
- DigitalOcean Agent Platform API key (optional, for full functionality)

### 2. Configuration

Copy and configure the environment file:

```bash
cp MAIA-vue-ai-example/env.local MAIA-vue-ai-example/.env
```

Edit `MAIA-vue-ai-example/.env` and configure:

```bash
# Required: DigitalOcean Agent Platform
DIGITALOCEAN_PERSONAL_API_KEY=your_actual_api_key_here
DIGITALOCEAN_GENAI_ENDPOINT=https://vzfujeetn2dkj4d5awhvvibo.agents.do-ai.run/api/v1

# Optional: Other AI Providers
ANTHROPIC_API_KEY=your_anthropic_key_here
GEMINI_API_KEY=your_gemini_key_here
DEEPSEEK_API_KEY=your_deepseek_key_here

# Security Settings
SINGLE_PATIENT_MODE=true
PATIENT_ID=demo_patient_001
SESSION_SECRET=your_secure_session_secret_here
```

### 3. Start Services

```bash
# Start all services
docker-compose -f docker-compose.maia-secure.yml up -d

# View logs
docker-compose -f docker-compose.maia-secure.yml logs -f maia-vue-ai-secure
```

### 4. Access Application

- **MAIA Interface**: http://localhost:3001
- **CouchDB Admin**: http://localhost:5984/_utils
- **NOSH3 Interface**: http://localhost:4000

## 🔧 Development

### File Structure
```
MAIA-vue-ai-example/
├── server-secure.js          # Main backend server
├── src/
│   ├── components/           # Vue components
│   ├── composables/          # Vue composables
│   ├── types/               # TypeScript interfaces
│   └── utils/               # Utility functions
├── Dockerfile.secure         # Production Dockerfile
└── .env                     # Environment configuration
```

### Key Features
- **Multi-AI Support**: Personal AI, Anthropic, Gemini, DeepSeek
- **File Upload**: Support for multiple file types with context
- **Clean Logging**: Token counts, response times, context size
- **Security**: Single patient mode, rate limiting, security headers
- **Docker**: Containerized development environment

## 📝 Usage Examples

### 1. Basic Chat
1. Select AI provider from dropdown
2. Type message and click "Send"
3. View response with proper AI labeling

### 2. File Upload
1. Click paperclip button
2. Select file (.md, .pdf, .txt, .json)
3. File appears as badge in chat
4. Click eye icon to view file contents
5. File context available to all AI providers

### 3. Transcript Loading
1. Upload transcript.md file
2. Conversation history loaded as context
3. All AI providers can reference previous conversation

## 🔒 Security Features

- **Single Patient Mode**: Secure for personal demo
- **Rate Limiting**: Prevents abuse
- **Security Headers**: XSS protection
- **Non-root Docker**: Secure container execution
- **Environment Variables**: Secure API key management

## 🎯 Current Status

✅ **Completed Features:**
- Multi-AI provider integration
- File upload and context system
- Clean console logging
- Proper AI labeling
- Security configuration
- Docker containerization
- Development environment setup

🔄 **Ready for Next Phase:**
- Enhanced RAG integration
- Additional file type support
- Advanced context management
- Performance optimizations
- Extended AI provider support

## 📚 Documentation

- **API Endpoints**: See `server-secure.js` for all endpoints
- **Frontend Components**: See `src/components/` for UI components
- **State Management**: See `src/composables/` for application logic
- **Type Definitions**: See `src/types/` for TypeScript interfaces

---

**Last Updated**: July 26, 2025  
**Version**: 1.0.0 - Secure Local Development  
**Status**: ✅ Production Ready for Single-Patient Demo