#!/usr/bin/env bash

#author: Matheus Oliveira <matheusoliveiratux4me@gmail.com>
#version: 0.1
# License: GPL V3
#REFERENCES terminalroot.com.br
#describe: get data youtube video and chanel details

#--------------------


#CODIGO
function youtube(){
	local _video=$(mktemp)
	local _channel=$(mktemp)
	local url="https://youtube.com/channel"
	wget "$1" -O "$_video" 2>/dev/null
	local _title=$(grep '<title>' "$_video" | sed 's/<[^>]*>//g'| sed 's/- You.*//g')
	local _views=$(grep 'watch-view-count' "$_video" | sed -n 1p | sed 's/<[^>]*>//g')
	local _gosteis=$(grep 'like-button-renderer-like-button' "$_video" |sed -n 1p |sed 's/<[^>]*>//g;s///g')
	local _naogosteis=$(grep 'like-button-renderer-dislike-button' "$_video" |sed -n 1p |sed 's/<[^>]*>//g; s/ //g')
	local _idcanal=$(sed 's/channel/\n&/g' "$_video" | grep '^channel' | sed -n 1p| sed 's/isCrawlable.*//g;s/..,.*//g;s/.*\"//g')
	wget "$url/$_idcanal" -O "$_channel" 2>/dev/null
	local tchannel=$(sed -n '/title/{p; q;}' "$_channel" | sed 's/<title>*//g')
	local _sbscrb=$(sed -n '/subscriber-count/{p; q;}' "$_channel" | sed 's/.*subscriber-count//g'| sed 's/<[^>]*>//g;s/.*>//g')
	echo "Nome do canal:$tchannel"
	echo "Numero de inscritos:$_sbscrb"
	echo "Titulo do Video:$_title"
	echo $_views
	echo "Numero de gostei:$_gosteis"
	echo "Numero de nao gostei:$_naogosteis"



}
youtube "$1"
