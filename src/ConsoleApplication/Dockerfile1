FROM mcr.microsoft.com/dotnet/sdk:6.0

COPY . ./app/

WORKDIR ./app/

RUN dotnet restore "ConsoleApplication.csproj"
RUN dotnet build "ConsoleApplication.csproj" -c Release --no-restore
RUN dotnet publish "ConsoleApplication.csproj" -c Release --no-restore --no-build -o /publish

WORKDIR /publish
ENTRYPOINT ["dotnet", "ConsoleApplication.dll"]