# Stage 1: Builder
FROM rust:1.84-slim-bookworm as builder

# Install build dependencies
RUN apt-get update && apt-get install -y \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a new empty shell project
WORKDIR /usr/src/app
COPY Cargo.toml Cargo.lock ./

# Build dependencies - this is the caching Docker layer
RUN mkdir src && \
    echo "fn main() {}" > src/main.rs && \
    cargo build --release && \
    rm -rf src

# Build actual source code
COPY src ./src
RUN touch src/main.rs && cargo build --release

# Stage 2: Runtime
FROM debian:bookworm-slim

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    libssl3 \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -r appuser && useradd -r -g appuser appuser \
    && mkdir -p /home/appuser/.kube \
    && chown -R appuser:appuser /home/appuser \
    && chmod 700 /home/appuser/.kube

    # Copy the binary from builder
COPY --from=builder /usr/src/app/target/release/kube_app /usr/local/bin/

# Set proper permissions
RUN chown appuser:appuser /usr/local/bin/kube_app

# Use non-root user
USER appuser

# Run the binary
CMD ["kube_app"]

