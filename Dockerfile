FROM alpine:3.18.4

RUN apk upgrade --no-cache \
  && apk add --no-cache \
    mysql-client=10.11.5-r0 \
    python3=3.11.6-r0 \
    py3-six=1.16.0-r6 \
    py3-pip=23.1.2-r0 \
    py3-setuptools=67.7.2-r0 \
    libmagic=5.45-r0 \
    git=2.40.1-r0 \
    ca-certificates=20230506-r0 \
  && git clone https://github.com/s3tools/s3cmd.git --branch v2.3.0 /tmp/s3cmd \
  && cd /tmp/s3cmd \
  && pip install --no-cache-dir \
    python-dateutil==2.8.2 \
    python-magic==0.4.27 \
  && python3 /tmp/s3cmd/setup.py install \
  && cd / \
  && apk del py3-pip git \
  && rm -rf /root/.cache/pip /tmp/s3cmd

WORKDIR /s3
