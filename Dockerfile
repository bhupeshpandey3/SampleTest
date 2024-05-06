# Use the official .NET SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the project files into the container
COPY . .

# Build the application
RUN dotnet build -c Release -o out

EXPOSE 80

# Set the entry point for the application
ENTRYPOINT ["dotnet", "out/SampleTest.dll"]

