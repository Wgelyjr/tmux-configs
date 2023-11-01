#!/bin/bash
# just overriding the host time date status bar

function date_time() {

	date "+%R %D" | sed -z "s/\n//g"

}

function main() {
	date_time
}

main
