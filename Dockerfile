# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet build -c Release -o out

# Stage 2: Publish the application
FROM build AS publish
RUN dotnet publish -c Release -o out

# Stage 3: Final image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=publish /app/out ./

EXPOSE 80

# Set the entry point for the application
ENTRYPOINT ["dotnet", "SampleTest.dll"]

