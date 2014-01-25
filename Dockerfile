FROM ubuntu:latest
MAINTAINER Manfred Touron "m@42.am"

# Set locale to UTF-8
RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Update python
RUN apt-get install -qq python && \
    apt-get clean

# Install ez setup
ADD https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py /tmp/
RUN python /tmp/ez_setup.py >/dev/null && \
    rm -f /tmp/ez_setup.py

# Install pip
ADD https://raw.github.com/pypa/pip/master/contrib/get-pip.py /tmp/
RUN python /tmp/get-pip.py >/dev/null && \
    rm -f /tmp/get-pip.py

# Install virtualenv
RUN pip install -q virtualenv

# Setting up virtualenv
RUN virtualenv /venv
CMD /bin/bash --rcfile /venv/bin/activate
ENV VIRTUAL_ENV /venv
ENV PATH /venv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Install test dependencies
RUN pip install -q \
    pep8 \
    mock \
    nose \
    coverage \
    pylint

