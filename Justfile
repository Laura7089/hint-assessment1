#!/bin/env -S just --justfile

build: exam_number
    tectonic -X build

exam_number:
    [ -f ./src/exam_number.txt ] || echo "Sample" > ./src/exam_number.txt
