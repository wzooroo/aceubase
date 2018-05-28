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
## Настройка HTTPAceProxy
#### состояние из коробки
![aceu](https://user-images.githubusercontent.com/24189833/38779611-0ccc2372-40cb-11e8-94c1-2ba325a14481.png)
#### заходим в контейнер:
```
docker exec -it <имя контейнера> /bin/bash
```
#### редактируем следующее:
* root@aceub:/# nano /opt/HTTPAceProxy-master/plugins/config/p2pproxy.py

строчки 19 и 20
```
#Insert your email on torrent-tv.ru here
email = 're.place@me'
#Insert your torrent-tv account password
password ='ReplaceMe'
```
* root@aceub:/# nano /opt/HTTPAceProxy-master/modules/playlist.py

строчки 28 и 30


### Полная совместимость и поддержка офф. виджета ттв
### Для получения плейлиста, используйте ссылки вида:
* http://ip:8000/channels/?type=m3u
* http://ip:8000/archive/dates/?days=1 #(требуется доустановить ffmpeg)
#### после редактирования
![aceu1a](https://user-images.githubusercontent.com/24189833/38780048-583d0820-40d1-11e8-9635-779b2afb618a.png)

### Чистка кеш файлов старше чем 5 минут

#### запустить в кроне:
```
crontab -e
```
#### добавить в низ это содержание:
```
0 */2 * * * find /tmp/state/.ACEStream/.acestream_cache/* -depth -type f -mmin +5 -print0 | xargs -0 -r rm -f > /dev/null 2>&1
0 */2 * * * find /tmp/state/.ACEStream/collected_torrent_files/* -depth -type f -mmin +5 -print0 | xargs -0 -r rm -f > /dev/null 2>&1
```
## Логи
```
http://ip::9903/logtail/acestream # аналог в терминале tail -f -n 0 /var/log/supervisor/acestream.log
http://ip::9903/logtail/acehttp # аналог в терминале tail -f -n 0 /var/log/supervisor/acehttp.log
```
## Опционально
редактируем следующее:
* root@aceub:/# nano /opt/HTTPAceProxy-master/plugins/config/torrenttv.py
* root@aceub:/# nano /opt/HTTPAceProxy-master/plugins/config/torrentfilms.py
### Для получения плейлиста, используйте ссылки вида:
* http://ip:8000/torrenttv
* http://ip:8000/torrenttv/playlist.m3u
* http://ip:8000/proxyfilms

### Получение альтернативного плейлиста .m3u <900 каналов), Фильмотеки из 2860 фильмов по жанрам
#### запустить в кроне:
```
crontab -e
```
```
0 */6 * * * cd /var/www/html/ && ./scan-m3u.sh > /dev/null 2>&1
@reboot sleep 20 && cd /var/www/html/ && ./scan-m3u.sh > /dev/null 2>&1
0 */9 * * * curl -f -s -k -L -o /var/www/html/films.m3u http://roof.pythonanywhere.com/playlist/lists/?ip='ваш ip' > /dev/null 2>&1
```
#### плейлисты будут доступны по этим адресам:
```
http://ip:8844/tv.m3u         # если порт nginx 80 пробросить на 8844!
http://ip:8844/films.m3u
```
### Доступ в Веб-Интерфейс
Движок запускается с дополнительным ключом --access-token "some_token" (по умолчанию "access token" генерируется случайным образом при каждом запуске движка).
После этого веб-интерфейс будет доступен по ссылке: "http://host:6878/webui/app/69696969/server". После первоначальной настройки сводящейся в задании пароля, веб-интерфейс будет уже доступен по этой ссылке: "http://host:6878/server"
![916_12](https://user-images.githubusercontent.com/24189833/36639742-7690df16-1a13-11e8-8a34-fc2d6b7a4200.png)
