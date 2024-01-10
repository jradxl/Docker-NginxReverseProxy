# Docker with Nginx Reverse Proxy
Experiments with Docker and Nginx Reverse Proxy

Acting as an aide-memoire for my use of Docker.

A single instance of Ngnix runs in the container, with the servers defined in web-site.conf and default.conf

web-site.conf\
Contains the Websites, listening on ports 9000, 9001 and 9002

default-site.conf\
Contians the reverse proxies, listing on ports 80, 81 and 82

Use a browser on your host to access the website on http://localhost:8000\
Use curl to access the other two using  http://localhost:8001 and  http://localhost:8002 with verbose, thus\
curl -v localhost:8002 to see the headers

On the host, use ls -lt /var/lib/docker/volumes/nginx2-logs/_data
to see the data in the volume

Jan 2024

