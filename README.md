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

![aceu4](https://user-images.githubusercontent.com/24189833/36640896-9a4430a2-1a27-11e8-821e-d325a9c33b92.png)
