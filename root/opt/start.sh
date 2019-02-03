#!/bin/bash

# ACE Stream
/opt/acestream/start-engine --client-console --bind-all --access-token $1 --cache-dir /fs --state-dir /fs --vod-drop-max-age 120 --live-cache-type memory --vod-cache-type memory --live-buffer 25 --vod-buffer 10 --service-remote-access --stats-report-peers --log-file /fs/log >/dev/null 2>&1 &

# HTTPAceProxy
python /opt/HTTPAceProxy-master/acehttp.py >/dev/null 2>&1 &

# clear cache
while true; do

        if [[ -z `pgrep acestream` ]]; then
                        exit;
        fi

        sleep $2
        rm -rf /fs/.acestream_cache/* /fs/collected_torrent_files/*
done
