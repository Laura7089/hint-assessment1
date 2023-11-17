#!/bin/env -S just --justfile

TECTONIC := "tectonic -X"

build *args="": exam_number
    {{TECTONIC}} build {{ args }}

exam_number:
    [ -f ./src/exam_number.txt ] || echo "Sample" > ./src/exam_number.txt

clean:
    rm -rf ./build
