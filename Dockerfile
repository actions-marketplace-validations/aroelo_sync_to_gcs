FROM google/cloud-sdk:alpine
COPY main.sh /main.sh
ENTRYPOINT ["/main.sh"]