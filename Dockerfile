FROM phusion/baseimage:0.9.9
MAINTAINER John Smith <john.smith@example.com>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

# Install Ubuntu packages. New ubuntu packages should be added as their own apt-get install lines below the existing install commands.
RUN apt-get update
RUN apt-get install -y python-dev
RUN apt-get install -y python-pip
RUN apt-get install -y build-essential

# Clean up any files used by apt-get
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /root

RUN cd /tmp &&\
    curl http://download.redis.io/redis-stable.tar.gz | tar xz &&\
    make -C redis-stable &&\
    cp redis-stable/src/redis-cli /usr/local/bin &&\
    rm -rf /tmp/redis-stable

# Copy over our requirements.txt
ADD requirements.txt /root/requirements.txt

# Install our Python dependencies.
RUN pip install -r requirements.txt

# Copy over code and static assets.
ADD static /root/static
ADD application.py /root/application.py

# Add my runservice.sh shell script as a service and make sure it has the proper flags
ADD runservice.sh /etc/service/mywebserver/run
RUN chmod +x /etc/service/mywebserver/run

# Test our production image.
# ADD test /root/test
# RUN python -m unittest discover
# RUN rm -rf test

# Tell Docker that we are exposing the HTTP port
EXPOSE 80

# Finally, tell Docker to run the init service.
CMD ["/sbin/my_init"]