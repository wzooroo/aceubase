#!/bin/sh

FNAME="tv.m3u"
URL="http://pomoyka.lib.emergate.net/trash/ttv-list/ttv.all.iproxy.m3u?ip=192.168.178.92:6878"

GNAME="${FNAME}.gz"
curl --fail -R -z "${GNAME}" -o "${GNAME}" -H "Accept-Encoding: gzip" "${URL}" && \
 gunzip -c "${GNAME}" >"${FNAME}"
