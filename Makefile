#Задание цели по умолчанию (если будет вызван make)
.DEFAULT_GOAL := all

# Определяем переменные для сервисов
SERVICES := frontend backend

# Определяем порты для сервисов
FRONTEND_PORT := 3000
BACKEND_PORT := 8000

# Определяем цели
all: clear build run

# Определяем зависимости для цели build
build: $(addprefix build-,$(SERVICES))

# Определяем зависимости для цели run
run: $(addprefix run-,$(SERVICES))

# Определяем цели build- (build-frontend и build-backend)
build-%:
  cd $* && docker build -t taski-$* .

# Определяем цель run-frontend
run-frontend:
  docker run --name taski-frontend -d -p $(FRONTEND_PORT):$(FRONTEND_PORT) taski-frontend

# Определяем цель run-backend
run-backend:
  docker run --name taski-backend -d -p $(BACKEND_PORT):$(BACKEND_PORT) taski-backend

# Определяем цель clear
clear:
  docker rm --force taski-frontend taski-backend
