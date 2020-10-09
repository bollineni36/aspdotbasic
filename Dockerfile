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
WORKDIR C:/app/bin/Release/netcoreapp2.0
EXPOSE 5000
COPY . /app/out
ENTRYPOINT ["dotnet", "aspnetapp.dll"]
