FROM debian:bullseye-slim

RUN apt update && apt install -y curl wget locales cron

RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen

RUN locale-gen

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

RUN curl -fsSL https://raw.githubusercontent.com/wurmlab/genevalidator/master/install.sh -o /tmp/install.sh
RUN /bin/bash /tmp/install.sh .

COPY ./cron/crontab /etc/cron.d/tmpclean
RUN crontab /etc/cron.d/tmpclean

COPY ./cron/exec.sh /root/exec.sh
RUN chmod +x /root/exec.sh

COPY ./cron/cron.sh /root/cron.sh
RUN chmod +x /root/cron.sh

VOLUME ["/genevalidator/blast_db"]

CMD ["/root/exec.sh"]