FROM phusion/baseimage

# Set correct environment variables
ENV DEBIAN_FRONTEND=noninteractive HOME="/root" TERM=xterm LANG=ru_RU.UTF-8 LANGUAGE=ru_RU:ru LC_ALL=ru_RU.UTF-8
WORKDIR /tmp
# set ports
EXPOSE 8621 62062 9944 9903 6878 8000 80

# set config volume
VOLUME /mnt/films/

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Add required files that are local
ADD src/ /root/

# Set the locale
RUN locale-gen ru_RU.UTF-8 && \

#set start file
mv /root/start.sh /etc/my_init.d/start.sh && \
chmod +x /etc/my_init.d/start.sh && \

# update apt and install dependencies
#apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
add-apt-repository ppa:jonathonf/python-2.7 -y && \
apt-get update -y && \
apt-get install -y \
build-essential \
python-dev \
python2.7 \
#python-setuptools \
gcc \
#python-pip \
curl \
python-libxslt1 \
python-m2crypto \
python-apsw \
supervisor \
wget \
mc \
nano \
net-tools \
htop \
nginx && \
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
python get-pip.py && \
#pip install -U pip && \
#pip install --upgrade setuptools && \
pip install --upgrade psutil && \
pip install --upgrade gevent && \
#apt-get purge python-pip python-dev gcc build-essential python-setuptools -y && \
apt-get autoremove -y && \
mkdir -p /mnt/films && \

#acestream
wget -o - http://dl.acestream.org/linux/acestream_3.1.16_ubuntu_16.04_x86_64.tar.gz && \
tar -zxvf acestream_3.1.16_ubuntu_16.04_x86_64.tar.gz && \
mv acestream_3.1.16_ubuntu_16.04_x86_64 /opt/acestream && \

# install aceproxy
wget -o - https://github.com/pepsik-kiev/HTTPAceProxy/archive/master.zip -O aceproxy.zip && \
unzip aceproxy.zip -d /opt/ && \

# set supervisor file
mv /root/supervisord.conf /etc/supervisor/conf.d/supervisord.conf && \
mv /root/supervisor/supervisord.conf /etc/supervisor/supervisord.conf && \
mv /root/scan-m3u.sh /var/www/html/scan-m3u.sh && \
chmod +x /var/www/html/scan-m3u.sh && \

# set /tmp on tmpfs
echo "tmpfs /tmp tmpfs rw,nosuid,nodev 0 0" | tee -a /etc/fstab && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /opt/acestream/data/plugins/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man /usr/share/doc/*

WORKDIR /
