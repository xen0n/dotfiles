#!/bin/bash

hexdate () {
	local oid="$1"

	local ts="${oid:0:8}"

	date --date=@"$((0x$ts))" '+%F %T'
}

hnsdate () {
	local ts="$1"

	date --date=@"$(($ts / 10000000))" '+%F %T'
}
