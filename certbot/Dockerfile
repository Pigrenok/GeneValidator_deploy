FROM certbot/certbot:latest

# If this image should be run in AWS, then CERTARN should contain ACM certificate ARN,
# otherwise, not providing it, it will be build for local use only.
ARG CERTARN

ENV CERTARN=$CERTARN

ENV CERTFOLDER=/etc/letsencrypt/

RUN pip3 install --no-cache-dir awscli