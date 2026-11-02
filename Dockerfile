FROM oven/bun:1-debian

# 1. Cài đặt Python 3, venv và các công cụ audio/ONNX cơ bản
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    ffmpeg \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 2. Tạo môi trường ảo Python và cài thư viện ZeroTTS + Pillow
RUN python3 -m venv /app/.venv && \
    /app/.venv/bin/pip install --no-cache-dir zerotts pillow

# 3. Cài đặt dependencies cho Bun.js
COPY package.json bun.lock* ./
RUN bun install

# 4. Sao chép mã nguồn ứng dụng
COPY . .

# 5. Cổng kết nối & biến môi trường
EXPOSE 3000
ENV PORT=3000 \
    PYTHONUNBUFFERED=1 \
    OMP_NUM_THREADS=3 \
    OMP_WAIT_POLICY=PASSIVE

CMD ["bun", "run", "server.js"]
