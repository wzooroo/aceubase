![logo-text-test](https://user-images.githubusercontent.com/24189833/36645710-3deca456-1a6d-11e8-8bf0-84f078703d8d.png) (v3.1.16) 
# On the basis of A minimal Ubuntu base image modified for Docker-friendliness

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

# Для того чтобы посмотреть текущее состояние движка надо набрать в адресной строке Вашего браузера

```
http://ip.address.your.engine:9944/app/monitor
```
![aceu4](https://user-images.githubusercontent.com/24189833/36640896-9a4430a2-1a27-11e8-821e-d325a9c33b92.png)

# Для того чтобы получить список текущих значений надо набрать в адресной строке Вашего браузера
```
http://ip.address.your.engine:6878/webui/app/69696969/settings/get
```
![aceu4a](https://user-images.githubusercontent.com/24189833/36641002-381b6538-1a29-11e8-8c1f-aa7953b7c5ec.png)

Для того чтобы изменить их, на нужные Вам, делаем вот так в браузере... 
```
Как пример если IP вашего девайса с движком - 192.168.1.35
http://192.168.1.35:6878/webui/app/69696969/settings/set?live_buffer=25
http://192.168.1.35:6878/webui/app/69696969/settings/set?vod_buffer=10
http://192.168.1.35:6878/webui/app/69696969/settings/set?output_format_live=original
http://192.168.1.35:6878/webui/app/69696969/settings/set?output_format_vod=hls
http://192.168.1.35:6878/webui/app/69696969/settings/set?memory_cache_limit=314572800
и т.д.
```

# Получение плейлиста .m3u <900 каналов)

