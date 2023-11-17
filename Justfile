#!/bin/env -S just --justfile

TECTONIC := "tectonic -X"

build *args="": exam_number gsn_diag
    {{TECTONIC}} build {{ args }}

gsn_diag:
    mkdir -pv ./src/graphics
    drawio -x -o ./src/graphics/tsn_gsn.png ./src/tsn_gsn.drawio

watch *args="":
    pueue add watchexec -w src just build {{ args }}

exam_number:
    [ -f ./src/exam_number.txt ] || echo "Sample" > ./src/exam_number.txt

clean:
    rm -rfv ./build
    find ./src -iname "*.bkp" -exec rm -v {} \;
