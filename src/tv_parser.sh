#!/bin/sh
serverip="http://127.0.0.1"

path=`dirname $0`
parser="/usr/bin/jq"
filepath="/var/www/html/"

playlist_url="http://pomoyka.lib.emergate.net/trash/ttv-list/ttv.json"
json="$filepath/m3u/ttv.json"
outdir="$filepath/m3u"

header="#EXTM3U"
newline="ZFZFaZZZ"
#informational="informational"
informational="Религиозные"

url_prefix="$serverip:6878/ace/getstream?id="
#url_prefix="$serverip:6878/ace/manifest.m3u8?id="
url_postfix=""

mkdir -p $filepath >> /dev/null 2>&1
mkdir $filepath/m3u >> /dev/null 2>&1

rm $json >> /dev/null 2>&1
wget $playlist_url -O $json

data=`cat $json |$parser  '.channels|=sort_by(.cat,.name)'`
size=`echo $data |$parser  '.channels|length'`

if [ $size -gt 1 ]
then
  param="'.channels|=sort_by(.cat,.name)|.channels[]|select(.cat != \"$informational\")|\"#EXTINF:-1 group-title=\\\"\"+.cat+\"\\\" tvg-logo=\\\"$serverip/tv/\"+.name+\".png\\\", \"+.name+\"$newline\"+\"$url_prefix\"+.url+\"$url_postfix\"'|sed 's/$newline/\n/g'"
  eval "echo \$header; echo \$data | " $parser "-r" $param > $outdir/tv.m3u

#  param="'.channels|=sort_by(.cat,.name)|.channels[]|select(.cat != \"$informational\")|\"#EXTINF:-1, \"+.name+\" (\"+.cat+\")$newline\"+\"$url_prefix\"+.url+\"$url_postfix\"'|sed 's/$newline/\n/g'"
#  eval "echo \$header; echo \$data | " $parser "-r" $param > $outdir/tv1.m3u
fi
