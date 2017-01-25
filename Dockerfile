FROM ubuntu:xenial
MAINTAINER Dan Lien <dan@danclien.com>
EXPOSE 3000
COPY ./dist /app
WORKDIR /app
RUN apt-get update && apt-get install -y \
    libgmp10 \
  && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["./hello-world"]
