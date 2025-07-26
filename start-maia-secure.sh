#!/bin/bash

# MAIA Secure Local Development Startup Script
# This script sets up MAIA for local development with DigitalOcean Agent Platform integration

set -e

echo "🚀 Starting MAIA Secure Local Development Environment"
echo "=================================================="

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker and try again."
    exit 1
fi

# Check if required files exist
if [ ! -f "./MAIA-vue-ai-example/env.local" ]; then
    echo "❌ Environment file not found: ./MAIA-vue-ai-example/env.local"
    echo "Please copy env.local.example and configure your API keys."
    exit 1
fi

# Create logs directory
mkdir -p logs

# Check if DigitalOcean API key is configured
if grep -q "your_digitalocean_personal_api_key_here" "./MAIA-vue-ai-example/env.local"; then
    echo "⚠️  Warning: DigitalOcean API key not configured in env.local"
    echo "   MAIA will run with mock responses. Configure DIGITALOCEAN_PERSONAL_API_KEY for full functionality."
fi

# Stop any existing containers
echo "🛑 Stopping existing containers..."
docker-compose -f docker-compose.maia-secure.yml down --remove-orphans

# Build and start containers
echo "🔨 Building and starting containers..."
docker-compose -f docker-compose.maia-secure.yml up --build -d

# Wait for services to be ready
echo "⏳ Waiting for services to be ready..."
sleep 10

# Check service health
echo "🏥 Checking service health..."

# Check MAIA health
if curl -f http://localhost:3001/health > /dev/null 2>&1; then
    echo "✅ MAIA is running at http://localhost:3001"
else
    echo "❌ MAIA health check failed"
fi

# Check CouchDB
if curl -f http://localhost:5984/ > /dev/null 2>&1; then
    echo "✅ CouchDB is running at http://localhost:5984"
else
    echo "❌ CouchDB health check failed"
fi

# Check NOSH3 (optional)
if curl -f http://localhost:4000/ > /dev/null 2>&1; then
    echo "✅ NOSH3 is running at http://localhost:4000"
else
    echo "⚠️  NOSH3 is not responding (optional service)"
fi

# Check Trustee-Community (optional)
if curl -f http://localhost:3000/ > /dev/null 2>&1; then
    echo "✅ Trustee-Community is running at http://localhost:3000"
else
    echo "⚠️  Trustee-Community is not responding (optional service)"
fi

echo ""
echo "🎉 MAIA Secure Local Development Environment is ready!"
echo ""
echo "📋 Service URLs:"
echo "   MAIA Chat Interface: http://localhost:3001"
echo "   CouchDB Admin: http://localhost:5984/_utils"
echo "   NOSH3 (optional): http://localhost:4000"
echo "   Trustee-Community (optional): http://localhost:3000"
echo ""
echo "🔧 Configuration:"
echo "   - Single Patient Mode: Enabled"
echo "   - Patient ID: demo_patient_001"
echo "   - DigitalOcean Agent Platform: Connected (if API key configured)"
echo ""
echo "📝 Logs:"
echo "   docker-compose -f docker-compose.maia-secure.yml logs -f maia-vue-ai-secure"
echo ""
echo "🛑 To stop: docker-compose -f docker-compose.maia-secure.yml down" 