FROM registry:3

COPY config.yml /etc/distribution/config.yml

EXPOSE 5000

ENTRYPOINT ["sh", "-c", "mkdir -p /logs/image-registry && exec registry serve /etc/distribution/config.yml >> /logs/image-registry/image-registry.log 2>&1"]
