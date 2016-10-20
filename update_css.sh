#! /bin/bash

pushd reveal.js
grunt css-themes
popd

cp -rf reveal.js/css static/reveal.js/
cp -rf reveal.js/js static/reveal.js/
cp -rf reveal.js/lib static/reveal.js/
cp -rf reveal.js/plugin static/reveal.js/
