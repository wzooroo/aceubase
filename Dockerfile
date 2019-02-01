FROM ubuntu:disco

# set ports
EXPOSE 8621 62062 6878 8081

# set config volume
VOLUME /mnt/films/

# Add required files that are local
ADD src/ /root/

# update apt and install dependencies
RUN \
apt-get update && apt-get upgrade -y && \
apt-get install -y --no-install-recommends \
python2.7 \
build-essential \
python-dev \
gcc \
curl \
python-apsw \
python-pip \
python-libxslt1 \
net-tools \
wget \
mc \
git \
nano && \
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
python get-pip.py && \
pip install --upgrade psutil && \
pip install setuptools cffi 'cython>=0.28' git+git://github.com/gevent/gevent.git#egg=gevent && \
apt-get autoremove -y && \
mkdir -p /mnt/films && \

#acestream
cd /opt/ && \
wget -o - http://acestream.org/downloads/linux-beta/acestream_3.1.35_ubuntu_18.04_x86_64.tar.gz && \
tar -zxvf acestream_3.1.35_ubuntu_18.04_x86_64.tar.gz && \


# install aceproxy
wget -o - https://github.com/pepsik-kiev/HTTPAceProxy/archive/master.zip -O aceproxy.zip && \
unzip aceproxy.zip && \

# clean up
apt-get clean && \
apt-get purge git python-dev gcc build-essential -y && \
rm -rf acestream_3.1.35_ubuntu_18.04_x86_64.tar.gz aceproxy.zip

RUN chmod +x /usr/bin/start.sh

CMD ["/usr/bin/start.sh"]




