FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY ["./HelloAKS.csproj", "./"]
RUN dotnet restore "./HelloAKS.csproj"
COPY . ./
WORKDIR "/src"
RUN dotnet build "HelloAKS.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "HelloAKS.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "HelloAKS.dll"]