FROM python:3.6-slim

RUN apt-get clean \
    && apt-get -y update

RUN apt-get -y install \
    nginx \
    python3-dev \
    build-essential

WORKDIR /app

COPY templates .
COPY app.py .
COPY requirements.txt .

RUN pip install -r requirements.txt --src /usr/local/src



EXPOSE 5000
CMD [ "python", "app.py" ]
