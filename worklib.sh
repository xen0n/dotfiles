#!/bin/bash

hexdate () {
	local ts="$1"

	date --date=@"$((0x$ts))"
}

hnsdate () {
	local ts="$1"

	date --date=@"$(($ts / 10000000))"
}
