#! /bin/sh

docker run -P --name web --link redis1:redis -d skibaa/rtdexample
