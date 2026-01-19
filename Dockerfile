# Use the latest Ubuntu Long Term Support (LTS) release as the base image.
# The 'latest' tag typically refers to the most recent LTS version, which is
# currently 24.04 (Noble Numbat).
FROM ubuntu:latest

COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set the working directory inside the container
WORKDIR /app

# Update the package lists and install any necessary packages
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
    curl \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy local files into the container
COPY . /app

# Define the command to run when the container starts
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
