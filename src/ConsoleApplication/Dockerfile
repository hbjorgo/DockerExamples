FROM mcr.microsoft.com/dotnet/sdk:6.0 as build

COPY . ./app/

WORKDIR ./app/

RUN dotnet restore "ConsoleApplication.csproj"
RUN dotnet build "ConsoleApplication.csproj" -c Release --no-restore
RUN dotnet publish "ConsoleApplication.csproj" -c Release --no-restore --no-build -o /publish

FROM mcr.microsoft.com/dotnet/runtime:6.0

COPY --from=build ./publish/ ./app/
WORKDIR ./app/
ENTRYPOINT ["dotnet", "ConsoleApplication.dll"]