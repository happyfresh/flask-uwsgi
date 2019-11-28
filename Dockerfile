FROM python:3.7

RUN pip install --no-cache-dir \
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

EXPOSE 80 443

CMD ["/usr/local/bin/supervisord", "-c", "/app/supervisord.conf"]
