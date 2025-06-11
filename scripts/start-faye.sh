#!/bin/bash

# Faye Server Management Script for Docker
# Usage: ./scripts/start-faye.sh [start|stop|restart|status|logs]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
COMPOSE_FILE="$PROJECT_DIR/docker-compose.faye.yml"

case "$1" in
    start)
        echo "🚀 Starting Faye server with Docker..."
        cd "$PROJECT_DIR"
        docker-compose -f docker-compose.faye.yml up -d
        echo "✅ Faye server started! Check logs with: ./scripts/start-faye.sh logs"
        echo "🌐 Faye server available at: http://localhost:9292/faye"
        ;;
    stop)
        echo "🛑 Stopping Faye server..."
        cd "$PROJECT_DIR"
        docker-compose -f docker-compose.faye.yml down
        echo "✅ Faye server stopped!"
        ;;
    restart)
        echo "🔄 Restarting Faye server..."
        cd "$PROJECT_DIR"
        docker-compose -f docker-compose.faye.yml down
        docker-compose -f docker-compose.faye.yml up -d
        echo "✅ Faye server restarted!"
        ;;
    status)
        echo "📊 Checking Faye server status..."
        cd "$PROJECT_DIR"
        docker-compose -f docker-compose.faye.yml ps
        ;;
    logs)
        echo "📝 Showing Faye server logs..."
        cd "$PROJECT_DIR"
        docker-compose -f docker-compose.faye.yml logs -f faye-server
        ;;
    build)
        echo "🔨 Building Faye server image..."
        cd "$PROJECT_DIR"
        docker-compose -f docker-compose.faye.yml build --no-cache
        echo "✅ Faye server image built!"
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status|logs|build}"
        echo ""
        echo "Commands:"
        echo "  start   - Start the Faye server"
        echo "  stop    - Stop the Faye server"
        echo "  restart - Restart the Faye server"
        echo "  status  - Show server status"
        echo "  logs    - Show server logs (press Ctrl+C to exit)"
        echo "  build   - Build the Docker image"
        exit 1
        ;;
esac 
