FROM debian:9

ENV TEST One "two two" three four

CMD ["/bin/sh", "-c", "echo $TEST"]

