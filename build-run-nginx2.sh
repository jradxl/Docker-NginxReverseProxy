#!/bin/bash

##Preparing Volume Persisted Data test.
# YYYY-MM-DD:HH:MM:SS date +"%Y-%m-%d:%T" 
today=$(date +"%Y-%m-%d")
today_now=$(date +"%Y-%m-%d:%T" )
echo "Now is: $today_now"
touch /var/lib/docker/volumes/nginx2-volume1/_data/FileWrittenFromHost_${today_now}.txt

docker stop nginx2 > /dev/null || true
docker rm   nginx2  > /dev/null || true

#Seems to not mine repeated invocations
docker volume create nginx2-volume1

docker volume create nginx2-logs
rm -rf /var/lib/docker/volumes/nginx2-logs/_data/*


docker build -t nginx2 .
docker run -d -p 8000:80 -p 8001:81 -p 8002:82 -v nginx2-volume1:/volume1 -v $(pwd)/bindmount1:/bindmount1 -v nginx2-logs:/var/log/nginx --name nginx2 nginx2
docker exec -it nginx2 /bin/bash

##Once you have exited from the Exec, the following will be run.

#docker ps -a
#docker image prune -af
#docker image ls -a

docker logs nginx2

##Volume Persisted Data. Time created filename will be shown
ls -lt /var/lib/docker/volumes/nginx2-volume1/_data/


