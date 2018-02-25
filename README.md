# Archimedes

A small containerized, concurrent and supervised Fibonacci Telnet server written in Elixir. It calculates a given `n` term position of the Fibonacci sequence not by iteration but with the following formula:

![Fibonacci Formula](https://wikimedia.org/api/rest_v1/media/math/render/svg/caa29fdc2d6f222745432c2f13edc1f9ed6ba4a6)

It's part of my study in Elixir.

Details about the formula calculation can be found [here](https://fschuindt.github.io/blog/2017/09/21/concurrent-calculation-of-fibonacci-in-elixir.html) and [here](https://en.wikipedia.org/wiki/Fibonacci_number).

## Usage

Use Docker to set it up.  
Once it's running you can access it with `telnet localhost 7171`.

Example:

```
$ telnet localhost 7171
Trying ::1...
Connected to localhost.
Escape character is '^]'.
8
21.0000
12
144.0000
56
225851433717.0004
```

It will crash with big numbers (due to the limited `Float` size) and with non-numerical inputs. It's intentional, so I can play with multiple clients, crashing one and having the others up and running intact in the Supervision Tree.

## To Do

- [ ] Protect Distillery release cookies in a `.env` file.
- [ ] Split `Dockerfile` and `docker-compose.yml` stages.
- [ ] Benchmark.
