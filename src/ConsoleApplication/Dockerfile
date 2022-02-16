FROM mcr.microsoft.com/dotnet/sdk:6.0 as build

COPY ./ConsoleApplication.csproj ./App/ConsoleApplication.csproj
RUN dotnet restore ./App/ConsoleApplication.csproj

COPY . ./App/

WORKDIR ./App/

RUN dotnet build "ConsoleApplication.csproj" -c Release --no-restore
RUN dotnet publish "ConsoleApplication.csproj" -c Release --no-restore --no-build -o /publish

FROM mcr.microsoft.com/dotnet/runtime:6.0

COPY --from=build ./publish/ App/
WORKDIR /App
ENTRYPOINT ["dotnet", "ConsoleApplication.dll"]