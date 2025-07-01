# Use Ubuntu as the base image
FROM ubuntu:latest

# Install necessary packages and AWS CLI v2
RUN apt-get update && \
    apt-get install -y \
    curl \
    unzip \
    # Install dependencies for Node.js
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/* && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip && \
    unzip -q /tmp/awscliv2.zip -d /tmp && \
    rm /tmp/awscliv2.zip && \
    /tmp/aws/install --update && \
    rm -rf /tmp/aws/ && \
    # Add NodeSource Node.js LTS repo and install Node.js
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    NODE_MAJOR=23 && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Clean up temporary files
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["aws"]
