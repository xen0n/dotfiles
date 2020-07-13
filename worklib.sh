#!/bin/bash

hexdate () {
	local oid="$1"

	local ts="${oid:0:8}"

	date --date=@"$((0x$ts))" '+%F %T'
}

hnsdate () {
	while [[ $# -gt 0 ]]; do
		local ts="$1"
		shift

		printf "%d: " "$ts"
		date --date=@"$(($ts / 10000000))" '+%F %T'
	done
}

qnch-github () {
	local repo="$1"

	qn-changelog-rs -c -r "$repo"
}

qnch-jira () {
	local repo="$1"

	qn-changelog-rs -c -r "$repo" -f jira
}
