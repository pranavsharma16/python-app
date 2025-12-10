# Choose base image
FROM python:3.12-slim AS builder
WORKDIR /app

# Copy & install dependencies 
RUN python -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install -requirements.txt

# Build app


##################
#2nd stage
##################

# Choose base image
FROM python:3.12-slim
WORKDIR /app

# Copy App from previous stage
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copy application code and run
COPY . .
CMD ["python", "app.py"]