# Usa la imagen base de SDK de .NET para la construcción
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build

# Establece el directorio de trabajo para la construcción
WORKDIR /src

# Copia el archivo .csproj y restaura las dependencias
COPY NetFunction/NetFunction.csproj NetFunction/
RUN dotnet restore NetFunction/NetFunction.csproj

# Copia el resto del código y realiza la publicación
COPY . .
WORKDIR /src/NetFunction
RUN dotnet publish NetFunction.csproj -c Release -o /app/publish

# Usa una imagen de runtime de .NET para ejecutar la aplicación
FROM mcr.microsoft.com/dotnet/aspnet:9.0

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia los archivos publicados desde la etapa anterior
COPY --from=build /app/publish .

# Expone el puerto en el que se ejecutará la función
EXPOSE 80

# Configura el punto de entrada para ejecutar la función en el contenedor
ENTRYPOINT ["dotnet", "NetFunction.dll"]