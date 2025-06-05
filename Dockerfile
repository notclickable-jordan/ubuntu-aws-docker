# Use Ubuntu as the base image
FROM ubuntu:latest

# Install necessary packages and AWS CLI v2
RUN apt-get update && \
    apt-get install -y \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/* && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip && \
    unzip -q /tmp/awscliv2.zip -d /tmp && \
    rm /tmp/awscliv2.zip && \
    /tmp/aws/install --update && \
    rm -rf /tmp/aws/

# Clean up temporary files
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the AWS CLI as the entrypoint for the image (optional but convenient)
ENTRYPOINT ["aws"]
