#! /bin/sh

docker run --rm  -P --name web --link redis1:redis -it  skibaa/rtdexample bash
