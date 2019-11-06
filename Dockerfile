FROM python:3.7

RUN pip install flask uwsgi supervisor boto3 pandas gensim awscli flask-cors

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
