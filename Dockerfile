FROM python:3.12-slim

WORKDIR /usr/src/app

COPY src/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ .

CMD [ "/bin/bash", "./download_hongkong_marine.sh" ]