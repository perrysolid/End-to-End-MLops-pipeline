FROM python:3.9-slim-buster

WORKDIR /app

COPY requirements.txt .

RUN apt-get update -y && apt-get install awscli -y
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python3", "app.py"]
