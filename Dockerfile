FROM sungardas/rancher-convoy

RUN apt-get update \
  && apt-get install -y libaio1 \
    ca-certificates \
    curl \
    python-pip \
    python-dev \
    build-essential \
  && rm -rf /var/lib/apt/lists/* \
  && pip install awscli

ADD http://s3.amazonaws.com/ec2metadata/ec2-metadata /usr/local/bin/ec2-metadata
RUN chmod 755 /usr/local/bin/ec2-metadata

RUN mkdir /scripts \
  && /assets

ADD /od-1m0 /assets/od-1m0
ADD /scripts/* /scripts/

RUN chmod +x /scripts/* \
  && mv /scripts/ec2-metadata-value /usr/local/bin/ec2-metadata-value

WORKDIR /scripts

ENTRYPOINT ["/scripts/entry"]

CMD ["daemon"]

