FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y nginx git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN rm -rf /var/www/html/* && \
    git clone https://github.com/josejuansanchez/2048.git /var/www/html && \
    rm -rf /var/www/html/.git

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]