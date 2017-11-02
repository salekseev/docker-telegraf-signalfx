FROM centos:7

ENV TELEGRAF_VERSION v1.4.0.sfx0

RUN set -ex && \
    yum -y install wget unzip && \
    wget -q https://github.com/signalfx/telegraf/releases/download/${TELEGRAF_VERSION}/Linux-x86_64.zip && \
    unzip Linux-x86_64.zip && \
    mv telegraf /usr/bin && \
    rm -f Linux-x86_64.zip && \
    chmod +x /usr/bin/telegraf && \
    mkdir -p /etc/telegraf && \
    yum -y remove wget unzip && \
    yum clean all

EXPOSE 8125/udp 8092/udp 8094

COPY telegraf.conf /etc/telegraf/telegraf.conf
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["telegraf"]
