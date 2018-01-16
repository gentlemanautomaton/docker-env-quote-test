# docker-env-quote-test

This is a test `Dockerfile` showing that double and single quotes contained
in an `ENV` statement are unexpectedly removed. The example `Dockerfile` has
the following `ENV` instructions:

```
ENV DQUOTE One "two two" three four
ENV SQUOTE One 'two two' three four
ENV BACKTICK One `two two` three four
```

If we build the image...

```
docker build -t gentlemanautomaton/docker-env-quote-test:latest .
```

and inspect it to see what the `Env` entry actually contains...

```
docker inspect gentlemanautomaton/docker-env-quote-test:latest

"Env": [
	"PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
	"DQUOTE=One two two three four",
	"SQUOTE=One two two three four",
	"BACKTICK=One `two two` three four"
],
```

we see that the quotes have clearly been removed. This behavior contradicts
[the documentation](https://docs.docker.com/engine/reference/builder/#env):

> The `ENV` instruction has two forms. The first form, `ENV <key> <value>`, will
> set a single variable to a value. The entire string after the first space will
> be treated as the `<value>` - including characters such as spaces and quotes.

The test result was produced with the following `docker-ce` environment:

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

```
docker info

Containers: 3
 Running: 0
 Paused: 0
 Stopped: 3
Images: 361
Server Version: 18.01.0-ce
Storage Driver: overlay2
 Backing Filesystem: extfs
 Supports d_type: true
 Native Overlay Diff: true
Logging Driver: json-file
Cgroup Driver: cgroupfs
Plugins:
 Volume: local
 Network: bridge host macvlan null overlay
 Log: awslogs fluentd gcplogs gelf journald json-file logentries splunk syslog
Swarm: inactive
Runtimes: runc
Default Runtime: runc
Init Binary: docker-init
containerd version: 89623f28b87a6004d4b785663257362d1658a729
runc version: b2567b37d7b75eb4cf325b77297b140ea686ce8f
init version: 949e6fa
Security Options:
 apparmor
 seccomp
  Profile: default
Kernel Version: 4.13.0-25-generic
Operating System: Ubuntu 17.10
OSType: linux
Architecture: x86_64
CPUs: 16
Total Memory: 31.47GiB
Name: scj83
ID: SVWR:PGRT:4NZT:KVIT:DVBE:EKDI:GG2T:46U2:5PEW:X4UL:LGQZ:SEL4
Docker Root Dir: /var/lib/docker
Debug Mode (client): false
Debug Mode (server): false
Registry: https://index.docker.io/v1/
Labels:
Experimental: false
Insecure Registries:
 127.0.0.0/8
Live Restore Enabled: false

WARNING: No swap limit support
```
