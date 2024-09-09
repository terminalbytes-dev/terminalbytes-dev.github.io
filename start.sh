#!/usr/bin/env sh

hugo --gc --cleanDestinationDir
hugo server --disableFastRender --logLevel info
