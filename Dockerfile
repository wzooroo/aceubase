FROM phusion/baseimage:master

# Set correct environment variables
ENV DEBIAN_FRONTEND=noninteractive HOME="/root" TERM=xterm LANG=ru_RU.UTF-8 LANGUAGE=ru_RU:ru LC_ALL=ru_RU.UTF-8
WORKDIR /tmp
# set ports
EXPOSE 8621 62062 6878 8000

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
apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
#add-apt-repository ppa:jonathonf/python-2.7 -y && \
#apt-get update -y && \
apt-get install -y \
build-essential \
python-dev \
python3-distutils \
python3 \
gcc \
curl \
psmisc \
#python-libxslt1 \
#python-m2crypto \
wget \
git \
mc \
nano \
#net-tools \
#iputils-ping \
tzdata \
htop && \
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
python3 get-pip.py && \
pip3 install --upgrade supervisor && \
pip3 install --user https://github.com/rogerbinns/apsw/releases/download/3.26.0-r1/apsw-3.26.0-r1.zip --global-option=fetch --global-option=--version --global-option=3.26.0 --global-option=--all --global-option=build --global-option=--enable-all-extensions && \
pip3 install --upgrade b2 && \
pip3 install speedtest-cli && \
pip3 install --upgrade psutil && \
pip3 install setuptools cffi 'cython>=0.28' git+git://github.com/gevent/gevent.git#egg=gevent && \
curl https://gist.githubusercontent.com/danmackinlay/176149/raw/d60b505a585dda836fadecca8f6b03884153196b/supervisord.sh > /etc/init.d/supervisord && \
apt-get purge git python-dev gcc build-essential python3-distutils -y && \
apt-get autoremove -y && \
mkdir -p /mnt/films && \

#acestream
wget -o - http://acestream.org/downloads/linux-beta/acestream_3.1.35_ubuntu_18.04_x86_64.tar.gz && \
tar -zxvf acestream_3.1.35_ubuntu_18.04_x86_64.tar.gz && \
mv acestream_3.1.35_ubuntu_18.04_x86_64 /opt/acestream && \

# install aceproxy
wget -o - https://github.com/pepsik-kiev/HTTPAceProxy/archive/master.zip -O aceproxy.zip && \
unzip aceproxy.zip -d /opt/ && \

# set supervisor file
mv /root/supervisord.conf /etc/supervisor/conf.d/supervisord.conf && \
mv /root/supervisor/supervisord.conf /etc/supervisor/supervisord.conf && \

# set /tmp on tmpfs
echo "tmpfs /tmp tmpfs rw,nosuid,nodev 0 0" | tee -a /etc/fstab && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /opt/acestream/data/plugins/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man /usr/share/doc/*

WORKDIR /

