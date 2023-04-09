# Use the latest Alpine image
FROM alpine:latest

# Update the package repository and install curl
RUN apk update && apk add --no-cache curl

# Install Python3 and pip
RUN apk add --no-cache python3 py3-pip

# Install git
RUN apk add --no-cache git

# Clone the gpt-cli repository and install it
RUN git clone https://github.com/lapwat/gpt-cli.git /gpt-cli

RUN cd /gpt-cli && \
    pip3 install --no-cache-dir --ignore-installed -r requirements.txt
COPY .gptrc /root

# Set the working directory
WORKDIR /app

# Copy any local files into the container
COPY . /app

# Set the entrypoint for the container
ENTRYPOINT ["python3", "/gpt-cli/gpt.py"]
