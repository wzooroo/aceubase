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
# Настройка HTTPAceProxy 
заходим в контейнер:
```
docker exec -it aceub /bin/bash
```
редактируем следующее:
```
root@aceub:/# nano /opt/HTTPAceProxy-master/plugins/modules/playlist.py
root@aceub:/# nano /opt/HTTPAceProxy-master/plugins/torrenttv_api.py
root@aceub:/# nano /opt/HTTPAceProxy-master/plugins/config/torrenttv.py
root@aceub:/# nano /opt/HTTPAceProxy-master/plugins/config/p2pproxy.py
root@aceub:/# nano /opt/HTTPAceProxy-master/plugins/config/torrentfilms.py
```
Для получения плейлиста, используйте ссылки вида:
```
http://ip:8000/torrenttv
http://ip:8000/torrenttv/playlist.m3u
http://ip:8000/channels/?type=m3u
http://ip:8000/archive/dates/?days=1 #(требуется доустановить ffmpeg)
```
# Полная совместимость и поддержка офф. виджета ттв
![screenshot_20180310-221051](https://user-images.githubusercontent.com/24189833/37247828-fb1ffc72-24c1-11e8-9225-fe2d93954b2f.png)
![screenshot_20180310-221116](https://user-images.githubusercontent.com/24189833/37247829-fb38e020-24c1-11e8-9027-554f04bc9145.png)
![screenshot_20180310-221124](https://user-images.githubusercontent.com/24189833/37247830-fb5205e6-24c1-11e8-8568-bdfccd109671.png)


# Получение альтернативного плейлиста .m3u <900 каналов), Фильмотеки из 2860 фильмов по жанрам + чистка кеш файлов старше чем 5 минут

запустить в кроне:
```
crontab -e
```

добавить в низ это содержание:
```
0 */2 * * * find /tmp/state/.ACEStream/.acestream_cache/* -depth -type f -mmin +5 -print0 | xargs -0 -r rm -f > /dev/null 2>&1
0 */2 * * * find /tmp/state/.ACEStream/collected_torrent_files/* -depth -type f -mmin +5 -print0 | xargs -0 -r rm -f > /dev/null 2>&1
0 */6 * * * curl -f -s -k -L -o /var/www/html/aceall.m3u http://pomoyka.lib.emergate.net/trash/ttv-list/ttv.all.iproxy.m3u?ip=ip:6878 > /dev/null 2>&1
@reboot sleep 20 && curl -f -s -k -L -o /var/www/html/aceall.m3u http://pomoyka.lib.emergate.net/trash/ttv-list/ttv.all.iproxy.m3u?ip=ip:6878 > /dev/null 2>&1
0 */9 * * * curl -f -s -k -L -o /var/www/html/films.m3u http://roof.pythonanywhere.com/playlist/lists/?ip='ваш ip' > /dev/null 2>&1
0 */6 * * * cd /var/www/html/ && ./scan-m3u.sh
```

плейлисты будут доступны по этим адресам:
```
http://ip:8844/aceall.m3u  # если порт nginx 80 пробросить на 8844!
http://ip:8844/tv.m3u
http://ip:8844/films.m3u
```
![img_0227](https://user-images.githubusercontent.com/24189833/38192537-ab2c6094-366d-11e8-8434-ac44922a1d11.JPG)

# Логи

в HTTPAceProxy/aceconfig.py правим строчку 140 на:
```
logfile = "/var/log/supervisor/acehttp.log"
```
будет доступно по ссылкам:

```
http://ip::9903/logtail/acestream # аналог в терминале tail -f -n 0 /var/log/supervisor/acestream.log
http://ip::9903/logtail/acehttp # аналог в терминале tail -f -n 0 /var/log/supervisor/acehttp.log
```

