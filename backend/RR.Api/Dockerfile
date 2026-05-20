FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# Copy csproj files for all projects to leverage Docker layer caching
COPY ["RR.Api/RR.Api.csproj", "RR.Api/"]
COPY ["RR.Application/RR.Application.csproj", "RR.Application/"]
COPY ["RR.Domain/RR.Domain.csproj", "RR.Domain/"]
COPY ["RR.Infrastructure/RR.Infrastructure.csproj", "RR.Infrastructure/"]
COPY ["RR.Migrations/RR.Migrations.csproj", "RR.Migrations/"]

RUN dotnet restore "RR.Api/RR.Api.csproj"

# Copy everything else and build the app
COPY . .
WORKDIR "/src/RR.Api"
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app
COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:8080

ENTRYPOINT ["dotnet", "RR.Api.dll"]