FROM kv1980/ubuntu_nano as my_small_nano
MAINTAINER Krishna Vinay vinaysm1@gmail.com
ENV name KV
RUN apt-get update -y
RUN apt-get install curl -y

FROM alpine
COPY --from=my_small_nano /shared-folder/notes.txt /notes.txt
ENTRYPOINT echo "Running this from alpine"; cat notes.txt
