# Use the official TeamCity agent image as the base
FROM jetbrains/teamcity-agent:latest

USER root

# Clean the APT cache and update the package lists, then install wget and gnupg
RUN rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    gnupg && \
    wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | apt-key add - && \
    echo "deb https://packages.adoptium.net/artifactory/deb focal main" | tee /etc/apt/sources.list.d/adoptium.list && \
    apt-get update

# Install Adoptium JDK 8
RUN apt-get install -y --no-install-recommends temurin-8-jdk

# Install Adoptium JDK 11
RUN apt-get install -y --no-install-recommends temurin-11-jdk

# Install Adoptium JDK 17
RUN apt-get install -y --no-install-recommends temurin-17-jdk

# Install Adoptium JDK 21
RUN apt-get install -y --no-install-recommends temurin-21-jdk

# Set environment variables for the JDK installations
ENV JAVA_HOME_8_X64=/usr/lib/jvm/temurin-8-jdk-amd64
ENV JAVA_HOME_11_X64=/usr/lib/jvm/temurin-11-jdk-amd64
ENV JAVA_HOME_17_X64=/usr/lib/jvm/temurin-17-jdk-amd64
ENV JAVA_HOME_21_X64=/usr/lib/jvm/temurin-21-jdk-amd64
ENV PATH=$PATH:/usr/lib/jvm/temurin-8-jdk-amd64/bin:/usr/lib/jvm/temurin-11-jdk-amd64/bin:/usr/lib/jvm/temurin-21-jdk-amd64/bin

# Set the default JDK to use
ENV JAVA_HOME=/usr/lib/jvm/temurin-21-jdk-amd64

# Additional configuration or cleanup if necessary
RUN apt-get clean && rm -rf /var/lib/apt/lists/*