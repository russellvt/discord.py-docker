{% include 'WARNING' %}
ARG PYTHON_VERSION
FROM python:$PYTHON_VERSION-slim-stretch
{% include 'LABEL' %}

RUN apt-get update && \
    # basic deps
    apt-get install -y -qq git openssl ssh gettext sudo build-essential \
    # voice support
    libffi-dev libsodium-dev libopus-dev \
    # apt is so noisy
    > /dev/null && \
    # update pip, install Cython & pytest
    pip install -U pip Cython pytest -q --retries 30 && \
    # remove caches
    rm -rf /root/.cache/pip/* && \
    rm -rf /var/lib/apt/lists/* && \
    find /usr/local -depth \
        \( \
            \( -type d -a \( -name test -o -name tests \) \) \
            -o \
            \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
        \) -exec rm -rf '{}' +

WORKDIR /app

CMD ["python"]
