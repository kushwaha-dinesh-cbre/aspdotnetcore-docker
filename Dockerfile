FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY ["lab02.csproj", "./"]
RUN dotnet restore "./lab02.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "lab02.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "lab02.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "lab02.dll"]
