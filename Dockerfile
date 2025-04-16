FROM python:3.6-slim

# Instala gcc y dependencias necesarias para compilar paquetes
RUN apt-get update && \
    apt-get install -y gcc python3-dev musl-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Establecemos el directorio de trabajo
WORKDIR /app

# Copiamos el archivo de dependencias e instalamos
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiamos el resto del código
COPY . .

# Variables de entorno para Redis
ENV REDIS_HOST=redis-queue
ENV REDIS_PORT=6379
ENV REDIS_CHANNEL=log_channel

# Exponemos el puerto de Redis (no es necesario, pero no hace daño)
EXPOSE 6379

# Comando para iniciar la aplicación
CMD ["python3", "main.py"]
