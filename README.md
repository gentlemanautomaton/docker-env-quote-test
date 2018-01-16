# docker-env-quote-test

This is a test `Dockerfile` showing that double quotes in an `ENV` statement are
unexpectedly removed. The example `Dockerfile` has this `ENV` instruction:

```
ENV TEST One "two two" three four
```

If we build the image...

```
docker build -t gentlemanautomaton/docker-env-quote-test:latest .
```

and inspect it to see what the `Env` entry actually contains...

```
docker inspect gentlemanautomaton/docker-env-quote-test

"Env": [
	"PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
	"TEST=One two two three four"
],
```

we see that the quotes have clearly been removed. This behavior contradicts
[the documentation](https://docs.docker.com/engine/reference/builder/#env):

> The `ENV` instruction has two forms. The first form, `ENV <key> <value>`, will
> set a single variable to a value. The entire string after the first space will
> be treated as the `<value>` - including characters such as spaces and quotes.

The test result was produced with this version of `docker-ce`:

```
docker version
Client:
 Version:       18.01.0-ce
 API version:   1.35
 Go version:    go1.9.2
 Git commit:    03596f5
 Built: Wed Jan 10 20:13:21 2018
 OS/Arch:       linux/amd64
 Experimental:  false
 Orchestrator:  swarm

Server:
 Engine:
  Version:      18.01.0-ce
  API version:  1.35 (minimum version 1.12)
  Go version:   go1.9.2
  Git commit:   03596f5
  Built:        Wed Jan 10 20:11:47 2018
  OS/Arch:      linux/amd64
  Experimental: false
```
