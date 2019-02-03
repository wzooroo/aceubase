FROM coresystem/acestream

WORKDIR /tmp

# set ports
EXPOSE 8621 62062 6878 8081

# set config volume
VOLUME /mnt/films/

# update apt and install dependencies
RUN \
apt-get update -y && \
apt-get install -y --no-install-recommends \
build-essential \
python-dev \
unzip \
gcc \
curl \
python-libxslt1 \
wget \
mc \
nano && \
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
python get-pip.py && \
rm -rf get-pip.py && \
pip install --upgrade psutil && \
pip install --upgrade gevent && \
mkdir -p /mnt/films && \

#acestream
cp /usr/lib/x86_64-linux-gnu/libcrypto.so.1.0.0 /opt/acestream/lib/libcrypto.so.1.0.0 && \
cp /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 /opt/acestream/lib/libcrypto.so.1.1 && \
cp /usr/lib/x86_64-linux-gnu/libssl.so.1.0.0 /opt/acestream/lib/libssl.so.1.0.0 && \
cp /usr/lib/x86_64-linux-gnu/libssl.so.1.1 /opt/acestream/lib/libssl.so.1.1 && \


# install aceproxy
wget -o - https://github.com/pepsik-kiev/HTTPAceProxy/archive/master.zip -O aceproxy.zip && \
unzip aceproxy.zip -d /opt/ && \

# clean up
apt-get clean && \
apt-get remove --purge python-dev gcc build-essential curl unzip -y && \
apt autoremove -y && \
rm -rf /tmp/* /opt/data/plugins/* /start.sh

# add local files
COPY root/ /
RUN chmod +x /opt/start.sh

WORKDIR /
