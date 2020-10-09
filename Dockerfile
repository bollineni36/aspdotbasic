FROM microsoft/aspnetcore-build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# build runtime image
FROM microsoft/aspnetcore-build
WORKDIR /app
EXPOSE 5000
COPY . /app/out
WORKDIR C:/app/bin/Release/netcoreapp2.0
ENTRYPOINT ["dotnet", "aspnetapp.dll"]
