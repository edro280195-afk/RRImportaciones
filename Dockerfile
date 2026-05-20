FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY backend/RR.Api/RR.Api.csproj ./RR.Api/
COPY backend/RR.Application/RR.Application.csproj ./RR.Application/
COPY backend/RR.Infrastructure/RR.Infrastructure.csproj ./RR.Infrastructure/
COPY backend/RR.Domain/RR.Domain.csproj ./RR.Domain/
COPY backend/RR.Migrations/RR.Migrations.csproj ./RR.Migrations/

RUN dotnet restore RR.Api/RR.Api.csproj

COPY backend/ .

RUN dotnet publish RR.Api/RR.Api.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app
COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:8080

ENTRYPOINT ["dotnet", "RR.Api.dll"]