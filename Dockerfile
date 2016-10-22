FROM sungardas/rancher-convoy

RUN mkdir /scripts \
 && apk update \
 && apk add python \
 && apk add py-pip \
 && apk add curl \
 && apk add bash \
 && pip install awscli

ADD http://s3.amazonaws.com/ec2metadata/ec2-metadata /usr/local/bin/ec2-metadata
RUN chmod 755 /usr/local/bin/ec2-metadata

ADD /scripts/* /scripts/
RUN chmod +x /scripts/*

RUN mv /scripts/ec2-metadata-value /usr/local/bin/ec2-metadata-value

WORKDIR /scripts

ENTRYPOINT ["/scripts/entry.sh"]

CMD ["daemon"]

