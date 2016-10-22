FROM sungardas/rancher-convoy

RUN mkdir /scripts \
  && apt-get update \
  && apt-get install -y libaio1 \
    ca-certificates \
    python-pip \
    python-dev \
    build-essential
  && rm -rf /var/lib/apt/lists/*
  && pip install awscli

ADD http://s3.amazonaws.com/ec2metadata/ec2-metadata /usr/local/bin/ec2-metadata
RUN chmod 755 /usr/local/bin/ec2-metadata

ADD /scripts/* /scripts/
RUN chmod +x /scripts/*

RUN mv /scripts/ec2-metadata-value /usr/local/bin/ec2-metadata-value

WORKDIR /scripts

ENTRYPOINT ["/scripts/entry.sh"]

CMD ["daemon"]

