# HOdlcoin mining with Docker

HOdlcoin is a cryptocoin designed for CPU-only hashing.

For more information, visit <http://hodlcoin.com>.

Alex Ellis has a handy Docker setup based on cpuminer-opt here: <https://github.com/alexellis/mine-with-docker/>

The pool he gives as an example doesn't work, perhaps it is no longer active.

Instead, I'm using the Stratum pool here: <http://hodl.optiminer.pl/>. The port is 5555.

We can invoke `docker service` or `docker run` to start our mining operation:

    docker run alexellis2/cpu-opt:2018-1-2 \
        ./cpuminer -a hodl -o stratum+tcp://hodl.optiminer.pl:5555 \
            -u $YOUR_HODL_WALLET_ADDRESS.$YOUR_OPTIONAL_HOST_IDENTIFIER -p x \
            --cpu-affinity 0xf # hex bitmask of cores to use, this uses the first 4


