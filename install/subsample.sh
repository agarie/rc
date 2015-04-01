#!/usr/bin/env bash

git clone https://github.com/dcjones/subsample.git
cd subsample && make

mv subsample /usr/local/bin/subsample

cd ..
rm -rf subsample
