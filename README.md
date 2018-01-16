# docker-env-quote-test

Demonstrates potential docker ENV quote parsing bug


Quotes in an `ENV` statement in a Dockerfile are unexpectedly removed.

For example:

```
ENV TEST One "two two" three four
```

```
docker build -t gentlemanautomaton/docker-env-quote-test:latest .
```

```
docker inspect gentlemanautomaton/docker-env-quote-test

"Env": [
	"PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
	"TEST=One two two three four"
],
```

This clearly shows that the quotes have been removed.
