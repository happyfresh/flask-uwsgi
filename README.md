### Base image for Flask + uWSGI

#### How to build
- `git clone https://github.com/happyfresh/flask-uwsgi.git`
- `cd flask-uwsgi/`
- Add or remove dependency as needed in `Dockerfile`
- `docker build -t happy/flask-uwsgi:python3.7 .`

#### How to update Docker Hub
- `docker push happy/flask-uwsgi:python3.7`

#### Required config file inside container
- /app/uwsgi.ini
- /app/supervisord.conf
