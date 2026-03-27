#!/usr/bin/env bash
#Courtesy of ChatGPT - make modulemap if the other script fails at the end for whatever reason
set -e
OUT_DIR="./pcm"

MAP_FILE=module_map.txt
> "$MAP_FILE"

find "$OUT_DIR" -name "*.pcm" | while read -r pcm; do
    header="${pcm#$OUT_DIR/}"
    header="${header%.pcm}"
    echo "-fmodule-file=$header=$pcm" >> "$MAP_FILE"
done