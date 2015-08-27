FROM python:2.7-slim

RUN apt-get update && apt-get install -y \
		mysql-client libmysqlclient-dev \
		postgresql-client libpq-dev \
		sqlite3 \
		gcc \
	--no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV DJANGO_VERSION 1.8.2

RUN pip install mysqlclient psycopg2 django=="$DJANGO_VERSION"

RUN mkdir -p /usr/src/app
COPY . /usr/src/app

COPY requirements.txt /usr/src/app/

WORKDIR /usr/src/app

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
