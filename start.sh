#!/bin/bash

# HIEofOne Local Development Startup Script

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
    local ports=("80" "443" "8080")
    for port in "${ports[@]}"; do
        if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1; then
            print_warning "Port $port is already in use"
        fi
    done
}

# Function to create necessary directories
create_directories() {
    print_status "Creating necessary directories..."
    mkdir -p traefik-acme
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

# Function to start services
start_services() {
    local mode=$1
    
    if [ "$mode" = "dev" ]; then
        print_status "Starting development environment..."
        docker-compose -f docker-compose.dev.yml up -d
        print_success "Development environment started"
        print_status "Access Traefik dashboard at: http://localhost:8080"
    else
        print_status "Starting production environment..."
        docker-compose up -d
        print_success "Production environment started"
        print_status "Access Traefik dashboard at: http://localhost:8080"
    fi
}

# Function to stop services
stop_services() {
    local mode=$1
    
    if [ "$mode" = "dev" ]; then
        print_status "Stopping development environment..."
        docker-compose -f docker-compose.dev.yml down
        print_success "Development environment stopped"
    else
        print_status "Stopping production environment..."
        docker-compose down
        print_success "Production environment stopped"
    fi
}

# Function to show logs
show_logs() {
    local mode=$1
    local service=$2
    
    if [ "$mode" = "dev" ]; then
        if [ -n "$service" ]; then
            docker-compose -f docker-compose.dev.yml logs -f "$service"
        else
            docker-compose -f docker-compose.dev.yml logs -f
        fi
    else
        if [ -n "$service" ]; then
            docker-compose logs -f "$service"
        else
            docker-compose logs -f
        fi
    fi
}

# Function to show status
show_status() {
    local mode=$1
    
    if [ "$mode" = "dev" ]; then
        docker-compose -f docker-compose.dev.yml ps
    else
        docker-compose ps
    fi
}

# Function to show help
show_help() {
    echo "HIEofOne Local Development Environment"
    echo ""
    echo "Usage: $0 [COMMAND] [OPTIONS]"
    echo ""
    echo "Commands:"
    echo "  start [dev|prod]     Start the environment (default: prod)"
    echo "  stop [dev|prod]      Stop the environment (default: prod)"
    echo "  restart [dev|prod]   Restart the environment (default: prod)"
    echo "  logs [dev|prod] [service]  Show logs (optional service name)"
    echo "  status [dev|prod]    Show service status"
    echo "  check                Check prerequisites"
    echo "  help                 Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 start dev         Start development environment"
    echo "  $0 start prod        Start production environment"
    echo "  $0 logs dev          Show development logs"
    echo "  $0 logs prod maia-vue-ai  Show logs for specific service"
    echo ""
    echo "Service URLs:"
    echo "  Traefik Dashboard:   http://localhost:8080"
    echo "  MAIA Vue AI:         http://maia.localhost"
    echo "  NOSH3:               http://nosh.localhost"
    echo "  Trustee Community:   http://trustee.localhost"
    echo "  Trustee Proxy:       http://proxy.localhost"
    echo "  Vue3-GNAP:           http://gnap.localhost"
    echo "  CouchDB:             http://db.localhost"
}

# Main script logic
case "${1:-help}" in
    "start")
        mode=${2:-prod}
        check_docker
        check_ports
        create_directories
        check_env_files
        start_services "$mode"
        ;;
    "stop")
        mode=${2:-prod}
        stop_services "$mode"
        ;;
    "restart")
        mode=${2:-prod}
        stop_services "$mode"
        sleep 2
        start_services "$mode"
        ;;
    "logs")
        mode=${2:-prod}
        service=$3
        show_logs "$mode" "$service"
        ;;
    "status")
        mode=${2:-prod}
        show_status "$mode"
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