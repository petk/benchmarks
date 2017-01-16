# Benchmarks

The following setups provide some performance overview of different technologies
for web developers.

## Apache Benchmark Tool

For measuring performance the Apache Benchmark tool has been used with the following
configuration:

```bash
ab -c 200 -n 200000 -k -r http://localhost/
```

## License

This repository is released under the [MIT License](LICENSE).
