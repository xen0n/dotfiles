#!/bin/bash

hexdate () {
	ts="$1"

	date --date=@"$((0x$ts))"
}
