docker system df
docker rm -vf $(docker ps -aq)
docker rmi -f $(docker images -aq)
docker builder prune -f
docker system prune -f
docker system df