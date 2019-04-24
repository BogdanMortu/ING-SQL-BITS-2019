#https://hub.docker.com/editions/community/docker-ce-desktop-windows
docker version


#Docker Info
docker info


#pull an image from docker-hub
docker pull mcr.microsoft.com/mssql/server:2019-CTP2.4-ubuntu
#location C:\Users\Public\Documents\Hyper-V\Virtual hard disks


#list all images
docker images 


#delete an image
docker rmi --force 2f


#run the container image with Docker
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=sql19-dev" `
-p 15222:1433 --name sql19-dev `
-v C:\Docker:/sql `
-d mcr.microsoft.com/mssql/server:2019-CTP2.3-ubuntu


#list all running containers
docker ps -a


#start a container
docker start sql19-dev


#stop a container
docker stop sql19-dev


#inspect a container
docker inspect 5


#remove a container
docker rm --force 5


#start an interactive bash shell inside your running container
docker exec -it sql19-dev bash


#check linux version
cat /etc/os-release


#Connect to SQL Server with sqlcmd
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'sql19-dev'


#restore AdventureWorks2017.bak with sql script in SSMS


#restore AdventureWorks2016.bak 

#create /backup folder in container
docker exec -it sql19-dev mkdir /var/opt/mssql/backup


#copy AdventureWorks2016.bak to /backup folder
docker cp C:\Docker\AdventureWorks2016.bak sql19-dev:/var/opt/mssql/backup



#DOCKERFILE
#a file on the Docker Host that contains commands that create a custom image


docker build -t customimage .


#list all images
docker images 
docker rmi --force customimage


#run my Custom container
docker run -d -p 15777:1433 --name customcontainer customimage


#list all containers
docker ps -a
docker rm --force 8d


docker start customcontainer


#bash shell
docker exec -it customcontainer bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'sql19-dev'

#Sharing images

#locally
docker save -o customimage.tar customimage  
docker load -i customimage.tar.tar


#login to Docker Hub
docker login


#tagging an image
docker tag customimage bogdanmortu/demo:latest
docker images

#push the image to Docker Hub into a privte repository
docker push bogdanmortu/demo:latest