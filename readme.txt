Self contained, sealed unit of software
batteries, O.S, code, configs, processes, networking, dependencies
It takes all the resources from the underlying OS.
client program named docker,
server program that manages Linux

Docker Basics:
docker info
docker images (list the images)

Running an Image:
docker run -ti <imagename> bash (interactive terminal) - This command will create a container from the image we specified.
docker run --rm -ti ubuntu bash sleep 5 - rm will remove the container when its stopped.
docker run --rm -it ubuntu:14.04 bash --name test: Running a container with a given name test.
docker exec hello cat hello - to execute commands in container hello.


$ winpty docker attach hello
root@3ff56862332d:/# hello
bash: hello: command not found
root@3ff56862332d:/#


docker ps (all running containers)
docker ps -a (all stopped containers)
docker ps -l (shows the latest created container includes all states)

docker commit <id> - This command will save the container as an image which can be used later.
You get the ID from the docker ps -a or ps -l (if the container is last stopped)
docker tag <<id>> <<image_name> - This will name the newly commited image with the given name.
docker commit <name> <image_name> - You can create a image only from a running or a stopped container.
You get the name from docker ps -a or ps -l (if the container is last stopped)


Detach/Attach:
Run Ctrl+P, Ctrl+Q combination to exit out of the container without stopping it.
docker run -d -ti ubuntu bash - this will detach the container and will leave the container running.
docker attach <name> - this will attach you back to the container that you detached.

Killing/Removing:
docker kill <container> - To stop the container
docker start <c1> - to start a container c1 thats stopped.
docker rm <c1> <c2> - deletes stopped containers c1 and c2
docker rmi <image1> - to remove image1. You need to stop and rm all the running containers before you can remove the image.


Network:
docker rum --rm --name echo-server -it -p 45678:45678 ubuntu:14.04 bash - Internal port 45678 is mapped externally to 45678
docker rum --rm --name echo-server -it -p 45678/udp ubuntu:14.04 bash - Here we didnt specify any external port. So available port is used. and its a UDP
docker port echo-server - This command will show which TCP port the internal 4568 is mapped to externally.
docker network list
docker network create learning - create a new network called learning.
docker run --rm -it --name catserver --net learning ubuntu:14.04 bash - Runs the container catserver and places it in the learning network. By default the containers run in bridge network.
docker run --rm -it --name dogserver --net learning ubuntu:14.04 bash - Runs the container dogserver and places it in learning network. now cat and dog can ping eachother.
docker network inspect <n1> - gives the details about n1 network and all the running containers
docker network connect <n1> <c1> - connects the c1 container to n1 network. Now all containers in n1 can ping each other.
docker network disconnect <n1> <C1> - disconnects c1 from n1 network.

Volumes:
Persistent -
docker run -d --rm -v /c/Users/Obstinate/Downloads/kv/Learnings/Docker/:/shared/ -it --net learning --name cows ubuntu:14.04

Ephermal - as long as in use and will be available till the container is running.
docker run --rm -v non-persistent-share -it --net learning --name cows ubuntu:14.04 - this will create a folder in the container named non-persistent-share.
This folder exists as long as the container is running.
docker run --rm --volumes-from cows -it --net learning --name horses ubuntu:14.04 - Now this will attached the shared folder from cows container to the horses container.
The contents of the folder are available to horses even after killing and deleting the cows container.
You may start another container and use the share even after the original cows container is removed.
docker run --rm --volumes-from horses -it --net learning --name donkeys ubuntu:14.04

docker run --rm -d -ti --env BREED=BRITISH_BULL_DOG --name bulldog ubuntu bash
docker run --rm -d -ti --link bulldog --name dog ubuntu bash
when you link the environments of bulldog to the dog container. The env variables of bulldog are available to dogs.


Backing Docker Images:
docker save -o <f1> <i1> <i2> <13> - This will take the backup of the images i1, i2, i3 to the file f1.
docker load -i <f1> - This is restore the images from the file f1.

docker login
docker push
docker pull
docker compose

play-with-docker.com - Site where you can play for free on docker.

cgroups - CPU and Memory reservations and limits.
NameSpace- Users, disks, network, inter process communication(IPC)


Docker swarms, docker Uiniversal control Plane(UCP) , Docker trusted registry (DTR) and Container Volumes data.
/var/lib/docker
systemctl status docker
systemctl start/stop/enable/disable docker
/var/run/docker.sock

Docker EE(Enterprise Edition)
engine, UCP, DTR
Docker CE(Community Edition)
dockerd - server
docker cli - client
--log-drive syslog/json-files
/etc/docker
