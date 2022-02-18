# Docker Examples
Examples on different docker optimizations

## How to use
To start with a clean docker environment, run `.\dockerprune.ps1` in the root folder to **delete all containers, images and cache** from the Docker environment.

## Image size

### Example 1
Use the same base image (SDK) for building and running the application.

Results in a big application image.

- Run `docker build -f Dockerfile1 -t example1 .`
- Run `docker run example1` to verify that it works
- Run `docker images` and observe image size

### Example 2
Use multi stage build to separate build image and application image.

Results in a reduced application image size.

- Run `docker build -f Dockerfile2 -t example2 .`
- Run `docker run example2` to verify that it works
- Run `docker images` and observe image size

### Example 3
Use a smaller application base image.

Results in an even smaller application image size.

- Run `docker build -f Dockerfile3 -t example3 .`
- Run `docker run example3` to verify that it works
- Run `docker images` and observe image size

### Example 4
Use an even smaller application base image together with a self-contained, trimmed dotnet executable.

Results in an even smaller application image size.

- Run `docker build -f Dockerfile4 -t example4 .`
- Run `docker run example4` to verify that it works
- Run `docker images` and observe image size

## Build time

### Example 5
Use layers to cache `dotnet restore` results

- Run Example 3 twice to see that everything is cached when rebuilt
- Edit `Program.cs`, and run Example 3 again to see that only the base layers are cached
- Run `docker build -f Dockerfile5 -t example5 .`
- Edit `Program.cs`, and run `docker build -f Dockerfile5 -t example5 .` again to see that base layers and `dotnet restore` results are cached
- Run `docker run example5` to verify that it works

### Example 6
Use .dockerignore to ignore unnecessary files and folders to reduce context size and to avoid secret files being copied to application image.

- In folder `ConsoleApplication` run `cp ../Assets/BigFile.txt .`
- Run `docker build -f Dockerfile6 -t example6 .`
- Observe output like this:  `=> => transferring context: 48.02MB`
- In folder `ConsoleApplication` run `cp ../Assets/BigFile.txt ./BigFile2.txt` and `cp ../Assets/.dockerignore .` (This is to add the .dockerignore file and a new big file that is not cached)
- Run `docker build -f Dockerfile6 -t example6 .`
- Observe output like this:  `=> => transferring context: 1.39kB`
- Run `docker run example6` to verify that it works

## Security
### Example 7
Run application as non-root user

Docker images default to root user. This is a potential security issue if someone manages to get access to the container.
Create a user with the minimum required privileges and run the application as this uses.

- Uncomment `Thread.Sleep(100_000);` on line 2 in `Program.cs` to prevent the application from exiting right away.
- Run `docker build -f Dockerfile7 -t example7 .`
- Run `docker run example7`
- Get a shell in the container and run `whoami` to print the name of the current user. `groups` lists the groups the current user is a member of.

## Useful commands
- `docker history <image>` shows the history of an image