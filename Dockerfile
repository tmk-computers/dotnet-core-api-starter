# Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app
COPY TMK.Api/*.csproj ./TMK.Api/
RUN dotnet restore TMK.Api/TMK.Api.csproj
COPY TMK.Api/. ./TMK.Api/
RUN dotnet publish TMK.Api/TMK.Api.csproj -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "TMK.Api.dll"]
