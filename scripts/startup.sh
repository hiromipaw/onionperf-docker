#!/bin/sh
cd onionperf;
onionperf measure --tor=/tor/src/or/tor \
--tgen=/shadow/src/plugin/shadow-plugin-tgen/build/tgen --twistd=/usr/local/bin/twistd;
