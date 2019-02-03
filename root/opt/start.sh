#!/bin/bash

python /opt/HTTPAceProxy-master/acehttp.py >/dev/null 2>&1 &

while true; do
        sleep 600
        rm -rf /tmp/state/.ACEStream/collected_torrent_files/*
done

#!/bin/bash

# ACE Stream
/opt/acestream/start-engine --client-console --bind-all --access-token $1 --cache-dir /fs --state-dir /fs --log-file /fs/log >/dev/null 2>&1 &

# clear cache
while true; do

        if [[ -z `pgrep acestream` ]]; then
                        exit;
        fi

        sleep $2
        rm -rf /fs/.acestream_cache/*
done
