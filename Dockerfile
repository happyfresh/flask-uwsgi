FROM python:3.7

RUN pip install --no-cache-dir \
    aws-xray-sdk \
    awscli \
    boto3 \
    flask \
    flask-caching \
    flask-cors \
    gensim \
    pandas \
    redis \
    supervisor \
    uwsgi

RUN set -x \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y parallel \
    && rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/nginx.list \
    && if [ -n "$tempDir" ]; then \
        apt-get purge -y --auto-remove \
        && rm -rf "$tempDir" /etc/apt/sources.list.d/temp.list; \
    fi

RUN curl https://s3.dualstack.ap-southeast-1.amazonaws.com/aws-xray-assets.ap-southeast-1/xray-daemon/aws-xray-daemon-3.x.deb -o xray-daemon.deb

RUN apt install ./xray-daemon.deb

EXPOSE 80 443

CMD ["/usr/local/bin/supervisord", "-c", "/app/supervisord.conf"]
