# Sample contents of Dockerfile
 # Stage 1
 FROM microsoft/aspnetcore-build
 WORKDIR /source

 # caches restore result by copying csproj file separately
 COPY *.csproj .
 RUN dotnet restore

 # copies the rest of your code
 COPY . .
 RUN dotnet publish --output /app/ --configuration Release

 # Stage 2
 FROM microsoft/aspnetcore
 WORKDIR /app
 EXPOSE 5000
 COPY . /app
 ENTRYPOINT ["dotnet", "myapp.dll"]
