FROM microsoft/aspnetcore-build:2.0
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# build runtime image
FROM microsoft/aspnetcore:2.0
WORKDIR /app
EXPOSE 5000
COPY . /app/out 
ENTRYPOINT ["dotnet", "aspnetapp.dll"]
