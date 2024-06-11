FROM ubuntu:latest
RUN apt-get update
RUN apt-get install nginx -y
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
CMD ["nginx",  '-g',  "daemon  off;"]
EXPOSE 80