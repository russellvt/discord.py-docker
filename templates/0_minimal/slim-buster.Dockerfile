{% include 'WARNING' %}
ARG PYTHON_VERSION

FROM python:$PYTHON_VERSION-slim-buster
{% include 'LABEL' %}

RUN apt-get update && \
    # basic deps
    apt-get install -y -qq git mercurial cloc openssl ssh gettext sudo build-essential \
    # voice support
    libffi-dev libsodium-dev libopus-dev ffmpeg \
    # apt is so noisy
    > /dev/null && \
    # update pip, install Cython, pytest, youtube-dl
    pip install -U pip git+https://github.com/cython/cython@master#egg=Cython git+https://github.com/pytest-dev/pytest@master#egg=pytest git+https://github.com/PyCQA/astroid@master#egg=astroid youtube-dl -q --retries 30 && \
    # remove caches
    rm -rf /root/.cache/pip/* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    find /usr/local -depth \
        \( \
            \( -type d -a \( -name test -o -name tests \) \) \
            -o \
            \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
        \) -exec rm -rf '{}' +

WORKDIR /app

CMD ["python"]
