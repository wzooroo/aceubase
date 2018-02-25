# Ace Stream Media(v3.1.16) on the basis of A minimal Ubuntu base image modified for Docker-friendliness

_Baseimage-docker only consumes 8.3 MB RAM and is much more powerful than Busybox or Alpine._

Baseimage-docker is a special [Docker](https://www.docker.com) image that is configured for correct use within Docker containers. It is Ubuntu, plus:

 * Modifications for Docker-friendliness.
 * Administration tools that are especially useful in the context of Docker.
 * Mechanisms for easily running multiple processes, [without violating the Docker philosophy](#docker_single_process).

You can use it as a base for your own Docker images.

Baseimage-docker is available for pulling from [the Docker registry](https://registry.hub.docker.com/u/phusion/baseimage/)!

Ace Stream – это медиа-платформа с децентрализованной/распределенной системой поставки и хранения мультимедийных данных, предназначенная для создания интернет-сервисов с функциями AVoD (Аудио и Видео по Запросу) и Live Streaming («живого»/потокового вещания), с обширной социальной и интерактивной составляющей.

# Доступ в Веб-Интерфейс
Движок запускается с дополнительным ключом --access-token "some_token" (по умолчанию "access token" генерируется случайным образом при каждом запуске движка).
После этого веб-интерфейс будет доступен по ссылке: "http://host:6878/webui/app/69696969/server". После первоначальной настройки сводящейся в задании пароля, веб-интерфейс будет уже доступен по этой ссылке: "http://host:6878/server"
![916_12](https://user-images.githubusercontent.com/24189833/36639742-7690df16-1a13-11e8-8a34-fc2d6b7a4200.png)

```
2018-02-25 10:59:45,121|BGTaskQueueThread-1|acestream.coreapp|got command: START PID a7db104fe838a8041ab9145d5a1f5da160dadf78 0 output_format=http
2018-02-25 10:59:45,127|BGTaskQueueThread-1|acestream.BGInstanceConnection|send STATE 1
2018-02-25 10:59:45,127|BGTaskQueueThread-1|acestream.coreapp|start_download_wrapper: dlfile=Animal Family HD fileindex=0
2018-02-25 10:59:45,128|BGTaskQueueThread-1|acestream.coreapp|start_download_wrapper: starting new download
2018-02-25 10:59:45,174|BGTaskQueueThread-1|acestream.coreapp|start_download: starting new download: infohash=df2751b221af280b391472974b942039339466b0 initialdlstatus=None output_format=default pausable=None transcode=(audio=False mp3=F$
2018-02-25 10:59:45,666|Timer-Thread-488|acestream.BGInstanceConnection|start_playback: telling plugin to start playback: is_ad=0 is_interruptable_ad=0 is_live=1 url=http://172.17.0.2:6878/content/df2751b221af280b391472974b942039339466b$
2018-02-25 10:59:45,669|Timer-Thread-488|acestream.BGInstanceConnection|start_playback: send cmd START http://172.17.0.2:6878/content/df2751b221af280b391472974b942039339466b0/0.244809501849 stream=1
2018-02-25 10:59:45,672|Timer-Thread-488|acestream.BGInstanceConnection|send STATE 2
2018-02-25 10:59:45,676|BGTaskQueueThread-1|acestream.coreapp|got command: EVENT play
2018-02-25 10:59:49,025|Timer-Thread-492|acestream.BGInstanceConnection|send STATE 3
2018-02-25 10:59:58,770|Timer-Thread-500|acestream.BGInstanceConnection|send STATE 2
2018-02-25 11:03:26,091|Timer-Thread-647|acestream.BGInstanceConnection|send STATE 3
2018-02-25 11:03:31,552|BGTaskQueueThread-1|acestream.coreapp|got command: STOP
2018-02-25 11:03:31,553|BGTaskQueueThread-1|acestream.BGInstanceConnection|send STATE 0
2018-02-25 11:03:31,554|BGTaskQueueThread-1|acestream.BGInstanceConnection|cleanup_playback
```
