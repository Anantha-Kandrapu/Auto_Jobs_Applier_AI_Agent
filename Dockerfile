FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    unzip \
    chromium \
    chromium-driver \
    x11vnc \
    xvfb \
    fluxbox \
    novnc \
    gcc \
    python3-dev \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set up VNC
RUN mkdir ~/.vnc && x11vnc -storepasswd aihawk ~/.vnc/passwd

# Set up display
ENV DISPLAY=:99

# Copy and setup startup script
COPY start-vnc.sh /
RUN chmod +x /start-vnc.sh

# Setup application
WORKDIR /app

# Copy ONLY requirements first (this is key for caching)
COPY requirements.txt .

# Clear pip cache and install requirements
RUN pip cache purge && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Start VNC and application
CMD ["/start-vnc.sh"]
