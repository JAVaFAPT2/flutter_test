# Use Windows Server Core as base image
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Set environment variables
ENV FLUTTER_VERSION=3.24.3
ENV JAVA_VERSION=17.0.9
ENV ANDROID_SDK_ROOT=C:\android-sdk
ENV ANDROID_HOME=C:\android-sdk
ENV FLUTTER_ROOT=C:\flutter
ENV PATH="C:\flutter\bin;C:\Program Files\Java\jdk-17.0.9\bin;C:\android-sdk\platform-tools;C:\android-sdk\tools;${PATH}"

# Create a user for development (without admin privileges)
RUN net user /add developer /passwordreq:no /expires:never /passwordchg:no

# Set user and working directory
USER developer
WORKDIR C:\Users\developer

# Install Chocolatey package manager as administrator (one-time setup)
USER administrator
RUN powershell -Command \
    Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install essential packages via Chocolatey
RUN choco install -y git curl 7zip nodejs openjdk17 android-sdk

# Switch back to developer user for remaining operations
USER developer

# Download and install Flutter SDK
RUN powershell -Command \
    $ProgressPreference = 'SilentlyContinue'; \
    Invoke-WebRequest -Uri "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_${FLUTTER_VERSION}.zip" -OutFile "flutter.zip"; \
    Expand-Archive -Path "flutter.zip" -DestinationPath "C:\"; \
    Remove-Item "flutter.zip"

# Precache Flutter dependencies
RUN flutter precache

# Accept Android licenses (this might require user interaction, consider --accept-licenses flag)
RUN flutter doctor --android-licenses

# Configure Flutter for all platforms
RUN flutter config --enable-web \
    && flutter config --enable-linux-desktop \
    && flutter config --enable-macos-desktop \
    && flutter config --enable-windows-desktop

# Create a directory for projects (will be mounted or cloned by agent)
RUN mkdir C:\Users\developer\projects

# Set the working directory to projects
WORKDIR C:\Users\developer\projects

# Optional: Install additional development tools
USER administrator
RUN choco install -y vscode powershell-core
USER developer

# Set default shell to PowerShell
SHELL ["powershell", "-Command"]
