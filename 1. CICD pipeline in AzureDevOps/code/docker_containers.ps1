
#pull an image from docker-hub
docker pull mcr.microsoft.com/mssql/server:2019-CTP2.3-ubuntu
#location C:\Users\Public\Documents\Hyper-V\Virtual hard disks


#list all images
docker images 


#delete an image
docker rmi --force 2f


#run the UAT container image with Docker
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=sql19-uat" `
-p 14331:1433 --name sql19-uat `
-d mcr.microsoft.com/mssql/server:2019-CTP2.3-ubuntu
# -v C:\Docker:/sql `


#run the PROD container image with Docker
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=sql19-prod" `
-p 14332:1433 --name sql19-prod `
-d mcr.microsoft.com/mssql/server:2019-CTP2.4-ubuntu
# -v C:\Docker:/sql `


#list all running containers
docker ps -a


#start a container
docker start sql19-dev
docker start sql19-uat
docker start sql19-prod


#stop a container
docker stop sql19-dev
docker stop sql19-uat
docker stop sql19-prod


#inspect a container
docker inspect sql19-dev
docker inspect sql19-uat
docker inspect sql19-prod


#remove a container
docker rm --force da


#start an interactive bash shell inside your running container
docker exec -it sql19-dev bash


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

docker build -t sql19-shared_dev .


#list all images
docker images 
docker rmi --force 78ae688b771e

docker ps -a
docker rm --force 2b7b6891a413

#run my Custom container
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=CustomContainer" `
-p 11143:1433 --name CustomContainer `
-d sql19-shared_dev

docker start CustomContainer

docker stop sql19-dev

#Sharing images

#locally
docker save -o export_sql19-dev.tar sql19-shared_dev  
docker load -i export_sql19-dev.tar


#Docker Hub
docker login

#tagging an image
docker tag sql19-shared_dev bogdanmortu/demo-20190422:v1

#push the image to Docker Hub into a privte repository
docker push bogdanmortu/demo-20190422:v1