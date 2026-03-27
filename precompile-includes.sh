#!/usr/bin/env bash
#Courtesy of ChatGPT - precompile headers which Linux tooling has no way of automatically doing, unlike Windows' Visual Studio
set -e

INCLUDE_DIR="/IdeaProjects/HiveWE/build/debug-linux/vcpkg_installed/x64-linux/include"
OUT_DIR="./pcm"
CXX=clang++
FLAGS="-std=c++23 -xc++-header"

mkdir -p "$OUT_DIR"

find "$INCLUDE_DIR" -name "*.hpp" -o -name "*.h" | while read -r header; do
    rel="${header#$INCLUDE_DIR/}"
    out="$OUT_DIR/${rel}.pcm"

    mkdir -p "$(dirname "$out")"

    echo "Compiling $rel"
    $CXX $FLAGS -I"$INCLUDE_DIR" "$header" -o "$out" || echo "❌ Failed: $rel"
done

MAP_FILE=module_map.txt
> "$MAP_FILE"

find "$OUT_DIR" -name "*.pcm" | while read -r pcm; do
    header="${pcm#$OUT_DIR/}"
    header="${header%.pcm}"
    echo "-fmodule-file=$header=$pcm" >> "$MAP_FILE"
done