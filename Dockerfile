FROM postgres:16
RUN apt update && apt install curl -y
RUN curl https://dl.min.io/client/mc/release/linux-amd64/mc -o /usr/bin/mc && chmod +x /usr/bin/mc
COPY backup.sh /usr/bin/backup.sh
RUN chmod +x /usr/bin/backup.sh
