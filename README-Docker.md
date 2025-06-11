# 🐳 Docker Setup cho Faye Server - Mac M1 Development

Hướng dẫn sử dụng Docker để chạy Faye server cho plugin Redmine App Notifications trên Mac M1.

## 📋 Yêu Cầu Tiên Quyết

- Docker Desktop cho Mac (với Apple Silicon support)
- Docker Compose v3.8+

## 🚀 Cài Đặt và Khởi Động

### 1. Build Docker Image
```bash
# Từ thư mục plugin: plugins/redmine_app_notifications/
./scripts/start-faye.sh build
```

### 2. Khởi động Faye Server
```bash
./scripts/start-faye.sh start
```

### 3. Kiểm tra trạng thái
```bash
./scripts/start-faye.sh status
```

## 🔧 Các Lệnh Quản Lý

### Script tiện ích
```bash
# Khởi động server
./scripts/start-faye.sh start

# Dừng server
./scripts/start-faye.sh stop

# Restart server
./scripts/start-faye.sh restart

# Xem logs (realtime)
./scripts/start-faye.sh logs

# Kiểm tra trạng thái
./scripts/start-faye.sh status

# Build lại image
./scripts/start-faye.sh build
```

### Docker Compose commands (thủ công)
```bash
# Khởi động với logs
docker-compose -f docker-compose.faye.yml up

# Khởi động background
docker-compose -f docker-compose.faye.yml up -d

# Dừng và remove containers
docker-compose -f docker-compose.faye.yml down

# Rebuild và khởi động
docker-compose -f docker-compose.faye.yml up --build
```

## 🌐 Truy Cập Faye Server

- **Faye Endpoint**: `http://localhost:9292/faye`
- **Health Check**: `http://localhost:9292/faye` (nếu trả về 200 OK thì server đang hoạt động)

## ⚙️ Cấu Hình Redmine Plugin

1. Vào **Administration** → **Plugins** → **Redmine App Notifications** → **Configure**

2. Thiết lập **Faye Server Address**:
   ```
   http://localhost:9292/faye
   ```

3. Nếu Redmine chạy trên Docker khác, sử dụng:
   ```
   http://host.docker.internal:9292/faye
   ```

## 🔍 Troubleshooting

### Port conflict
Nếu port 9292 bị sử dụng, chỉnh sửa `docker-compose.faye.yml`:
```yaml
ports:
  - "9293:9292"  # Đổi port bên trái
```

### Kiểm tra logs
```bash
./scripts/start-faye.sh logs
```

### Kiểm tra container
```bash
docker ps | grep faye
```

### Health check manual
```bash
curl -I http://localhost:9292/faye
```

## 🔧 Development Tips

### Hot reload không cần restart
Mặc định container sẽ tự động restart nếu crash.

### Debug mode
Để chạy với debug logs:
```bash
# Chỉnh sửa docker-compose.faye.yml, thêm:
environment:
  - RAILS_ENV=development
  - FAYE_DEBUG=1
```

### Network với Redmine Docker
Nếu Redmine cũng chạy trên Docker, thêm vào cùng network:
```yaml
# Trong redmine docker-compose.yml
networks:
  - redmine-network

# Network đã được define trong docker-compose.faye.yml
```

## 📊 Monitoring

### Container status
```bash
docker stats redmine_faye_server
```

### Memory usage
```bash
docker exec redmine_faye_server ps aux
```

## 🗑️ Cleanup

### Remove containers và images
```bash
docker-compose -f docker-compose.faye.yml down --rmi all

# Hoặc remove tất cả unused
docker system prune -a
```

## 🔒 Security Notes

- Container chạy với non-root user
- Chỉ expose port 9292
- Health check để đảm bảo availability
- Network isolation

## 📱 Test Integration

Sau khi Faye server chạy thành công:

1. Enable "In App Notifications" trong user preferences
2. Tạo một issue mới hoặc update issue
3. Kiểm tra notification icon ở top menu
4. Xem logs để confirm real-time updates:
   ```bash
   ./scripts/start-faye.sh logs
   ``` 
