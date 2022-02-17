# Docker Examples
Examples on different docker optimizations

## How to use
To start with a clean docker environment, run ```.\dockerprune.ps1``` in the root folder to **delete all containers, images and cache** from the Docker environment.

## Image size

### Example 1
Use the same base image (SDK) for building and running the application.

Results in a big application image.

- Run ```docker build -f Dockerfile1 -t example1 .```
- Run ```docker images``` and observe image size

### Example 2
Use multi stage build to separate build image and application image.

Results in a reduced application image size.

- Run ```docker build -f Dockerfile2 -t example2 .```
- Run ```docker images``` and observe image size

### Example 3
Use a smaller application base image.

Results in an even smaller application image size.

- Run ```docker build -f Dockerfile3 -t example3 .```
- Run ```docker images``` and observe image size

## Build time

### Example 4
Use layers to cache ```dotnet restore``` results

- Run Example 3 twice to see that everything is cached when rebuilt
- Edit ```Program.cs```, and run Example 3 again to see that only the base layers are cached
- Run ```docker build -f Dockerfile4 -t example4 .```
- Edit ```Program.cs```, and run ```docker build -f Dockerfile4 -t example4 .``` again to see that base layers and ```dotnet restore``` results are cached

### Example 5
Use .dockerignore to ignore unnecessary files and folders to reduce context size and to avoid secret files being copied to application image.

- In folder ```ConsoleApplication``` run ```cp ../Assets/BigFile.txt .```
- Run ```docker build -f Dockerfile5 -t example5 .```
- Observe output like this:  ```=> => transferring context: 48.02MB```
- In folder ```ConsoleApplication``` run ```cp ../Assets/BigFile.txt ./BigFile2.txt``` and ```cp ../Assets/.dockerignore .``` (This is to add the .dockerignore file and a new big file that is not cached)
- Run ```docker build -f Dockerfile5 -t example5 .```
- Observe output like this:  ```=> => transferring context: 1.39kB```