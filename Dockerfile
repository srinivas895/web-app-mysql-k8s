FROM python:3.6-slim

RUN apt-get clean \
    && apt-get -y update

RUN apt-get -y install \
    nginx \
    python3-dev \
    build-essential

WORKDIR /app

# Copy templates folder and files
COPY ./templates /app/templates
COPY app.py /app/
COPY requirements.txt /app/

RUN pip install -r requirements.txt --src /usr/local/src

EXPOSE 5000
CMD [ "python", "app.py" ]
