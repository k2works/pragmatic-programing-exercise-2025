# Dockerfile for Clojure development

# Use a base image with Java (required for Clojure)
FROM eclipse-temurin:17-jdk

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl rlwrap make git unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Clojure CLI tools
RUN curl -O https://download.clojure.org/install/linux-install-1.11.1.1347.sh && \
    chmod +x linux-install-1.11.1.1347.sh && \
    ./linux-install-1.11.1.1347.sh && \
    rm linux-install-1.11.1.1347.sh

# Install Leiningen (optional, but useful for some Clojure projects)
RUN curl -O https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && \
    chmod +x lein && \
    mv lein /usr/local/bin && \
    lein

# Set up working directory
WORKDIR /app

# Set environment variables
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH=$PATH:$JAVA_HOME/bin

# Default command
CMD ["clojure"]