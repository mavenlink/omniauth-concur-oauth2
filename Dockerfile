FROM ubuntu:latest
LABEL authors="nperry"

ENTRYPOINT ["top", "-b"]