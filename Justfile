#!/bin/env -S just --justfile

TECTONIC := "tectonic -X"
DIAGS := "tsn_gsn tsn_fta tsn_example"

WATCH_ARGS := "--on-busy-update restart"

build *args="": exam_number diagrams
    {{ TECTONIC }} build {{ args }}

diagrams:
    mkdir -pv ./src/graphics
    for diag in {{ DIAGS }}; do \
        drawio -x -o ./src/graphics/$diag.png ./src/$diag.drawio; \
    done

watch *args="":
    pueue add \
        watchexec \
        --project-origin . \
        {{ WATCH_ARGS }} \
        -w src \
        just build {{ args }}

exam_number:
    [ -f ./src/exam_number.txt ] || echo "Sample" > ./src/exam_number.txt

clean:
    rm -rfv ./build
    find ./src -iname "*.bkp" -exec rm -v {} \;
