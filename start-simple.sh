#!/bin/bash

# HIEofOne Local Testing Startup Script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if Docker is running
check_docker() {
    if ! docker info > /dev/null 2>&1; then
        print_error "Docker is not running. Please start Docker and try again."
        exit 1
    fi
    print_success "Docker is running"
}

# Function to check if ports are available
check_ports() {
    local ports=("3000" "3001" "4000" "4001" "5984")
    for port in "${ports[@]}"; do
        if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1; then
            print_warning "Port $port is already in use"
        fi
    done
}

# Function to create necessary directories
create_directories() {
    print_status "Creating necessary directories..."
    mkdir -p couchdb_data
    mkdir -p couchdb_config
    mkdir -p proxy_data
    print_success "Directories created"
}

# Function to check environment files
check_env_files() {
    local env_files=(
        "MAIA-vue-ai-example/.env"
        "nosh3/.env"
        "Trustee-Community/.env"
        "Trustee-Proxy/.env"
        "vue3-gnap/.env"
    )
    
    for env_file in "${env_files[@]}"; do
        if [ ! -f "$env_file" ]; then
            print_error "Missing environment file: $env_file"
            exit 1
        fi
    done
    print_success "All environment files found"
}

# Function to start simplified services
start_simple_services() {
    print_status "Starting simplified local testing environment..."
    docker-compose -f docker-compose.simple.yml up -d
    print_success "Simplified environment started"
    
    echo ""
    print_status "🌐 Access Points:"
    echo "  📊 CouchDB:        http://localhost:5984"
    echo "  🤖 MAIA Vue AI:    http://localhost:3001"
    echo "  🏥 NOSH3:          http://localhost:4000"
    echo "  🔐 Trustee:        http://localhost:3000"
    echo "  🔗 Trustee Proxy:  http://localhost:4001"
    echo "  🎯 Vue3-GNAP:      http://localhost:3002"
    echo ""
    print_status "🔑 Default Login Credentials:"
    echo "  Email: test@localhost"
    echo "  Password: test123"
    echo ""
    print_status "📝 Notes:"
    echo "  - This is a simplified testing environment"
    echo "  - No external API keys required"
    echo "  - Mock AI responses are used"
    echo "  - Email verification is bypassed"
}

# Function to stop simplified services
stop_simple_services() {
    print_status "Stopping simplified environment..."
    docker-compose -f docker-compose.simple.yml down
    print_success "Simplified environment stopped"
}

# Function to show logs
show_logs() {
    local service=$1
    
    if [ -n "$service" ]; then
        docker-compose -f docker-compose.simple.yml logs -f "$service"
    else
        docker-compose -f docker-compose.simple.yml logs -f
    fi
}

# Function to show status
show_status() {
    docker-compose -f docker-compose.simple.yml ps
}

# Function to show help
show_help() {
    echo "HIEofOne Local Testing Environment"
    echo ""
    echo "Usage: $0 [COMMAND] [OPTIONS]"
    echo ""
    echo "Commands:"
    echo "  start              Start the simplified testing environment"
    echo "  stop               Stop the simplified testing environment"
    echo "  restart            Restart the simplified testing environment"
    echo "  logs [service]     Show logs (optional service name)"
    echo "  status             Show service status"
    echo "  check              Check prerequisites"
    echo "  help               Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 start           Start simplified environment"
    echo "  $0 logs maia-vue-ai  Show logs for MAIA service"
    echo ""
    echo "Service URLs:"
    echo "  CouchDB:        http://localhost:5984"
    echo "  MAIA Vue AI:    http://localhost:3001"
    echo "  NOSH3:          http://localhost:4000"
    echo "  Trustee:        http://localhost:3000"
    echo "  Trustee Proxy:  http://localhost:4001"
    echo "  Vue3-GNAP:      http://localhost:3002"
    echo ""
    echo "Default Login:"
    echo "  Email: test@localhost"
    echo "  Password: test123"
}

# Main script logic
case "${1:-help}" in
    "start")
        check_docker
        check_ports
        create_directories
        check_env_files
        start_simple_services
        ;;
    "stop")
        stop_simple_services
        ;;
    "restart")
        stop_simple_services
        sleep 2
        start_simple_services
        ;;
    "logs")
        service=$2
        show_logs "$service"
        ;;
    "status")
        show_status
        ;;
    "check")
        check_docker
        check_ports
        check_env_files
        print_success "All checks passed"
        ;;
    "help"|*)
        show_help
        ;;
esac 