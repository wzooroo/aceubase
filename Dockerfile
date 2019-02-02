FROM ubuntu:disco

# set ports
EXPOSE 8621 62062 6878 8081

# set config volume
VOLUME /mnt/films/

# update apt and install dependencies
RUN \
apt-get update && apt-get upgrade -y && \
apt-get install -y --no-install-recommends \
python2.7 \
build-essential \
python-dev \
libssl1.0.0 \
unzip \
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
rm -rf get-pip.py && \
pip install --upgrade psutil && \
pip install setuptools cffi 'cython>=0.28' git+git://github.com/gevent/gevent.git#egg=gevent && \
apt-get autoremove -y && \
mkdir -p /mnt/films && \

#acestream
cd /opt/ && \
wget -o - http://acestream.org/downloads/linux-beta/acestream_3.1.35_ubuntu_18.04_x86_64.tar.gz && \
tar -zxvf acestream_3.1.35_ubuntu_18.04_x86_64.tar.gz && \
cp /usr/lib/x86_64-linux-gnu/libcrypto.so.1.0.0 /opt/lib/libcrypto.so.1.0.0 && \
cp /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 /opt/lib/libcrypto.so.1.1 && \
cp /usr/lib/x86_64-linux-gnu/libssl.so.1.0.0 /opt/lib/libssl.so.1.0.0 && \
cp /usr/lib/x86_64-linux-gnu/libssl.so.1.1 /opt/lib/libssl.so.1.1 && \


# install aceproxy
wget -o - https://github.com/pepsik-kiev/HTTPAceProxy/archive/master.zip -O aceproxy.zip && \
unzip aceproxy.zip && \

# set /tmp on tmpfs
#echo "tmpfs /tmp tmpfs rw,nosuid,nodev 0 0" | tee -a /etc/fstab && \
sed -i '$atmpfs /tmp tmpfs defaults,noatime,nosuid,nodev,noexec,mode=1777 0 0' /etc/fstab && \
sed -i '$atmpfs /var/tmp tmpfs defaults,noatime,nosuid,nodev,noexec,mode=1777 0 0' /etc/fstab && \

# clean up
apt-get clean && \
apt-get purge git python-dev gcc build-essential -y && \
rm -rf acestream_3.1.35_ubuntu_18.04_x86_64.tar.gz aceproxy.zip /opt/data/plugins/*

# add local files
COPY root/ /
RUN chmod +x /opt/start.sh

CMD ["/opt/start.sh"]




