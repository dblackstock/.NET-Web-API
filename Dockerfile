# Get base SDK Image from Microsoft
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app

# Copy the CSPROJ file and restore any dependencies via NuGet
COPY *.csproj ./
RUN dotnet restore

# Copy the project  files and build our release
COPY . ./
RUN dotnet publish -c Release -o out

# Generate runtime image
# The core SDK is only needed for the build, so for leanness we now only use the runtime
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
EXPOSE 5000
EXPOSE 5001
ENV ASPNETCORE_URLS=http://*:5000;https://*:5001
# Taking outputs from the previous build steps and putting them into the working directory
COPY --from=build-env /app/out .
# Entrypoint dictates what the container does when it starts, in this case it runs the dll with the dotnet command
ENTRYPOINT ["dotnet", "TodoApi.dll"]