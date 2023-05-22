# `bluejay-rb`

> **Warning**
> This project is still very early in its development and should be considered highly unstable and experimental. It is incomplete and not ready for production use.

> **Note**
> In an effort to get a working proof-of-concept, documentation and test coverage has been sacrificied. This will be corrected prior to a stable release.

`bluejay-rb` is a GraphQL engine for Ruby written primarily in Rust through the use of [`magnus`](https://github.com/matsadler/magnus).

## Goal

`bluejay-rb`'s goal is to provide a lightning fast GraphQL engine with first-class integration with [Sorbet](https://sorbet.org/). If you do not care deeply about one or both of these goals, then you should seriously consider using the excellent [`graphql-ruby`](https://graphql-ruby.org) gem, which has many more features than `bluejay-rb` in addition to being production-ready and much more customizable.

## Benchmarks

Some benchmarks comparing the performance of `bluejay-rb` against `graphql-ruby` (with C parser) are located at [`/bench`](/bench). The results of some of these benchmarks are included below.

<details>
  <summary>Parse + Execute (Ruby 3.2, YJIT enabled)</summary>

  ```
  Profiling IPS:
  Warming up --------------------------------------
              graphql   164.000  i/100ms
              bluejay     1.261k i/100ms
  Calculating -------------------------------------
              graphql      1.623k (± 1.9%) i/s -      8.200k in   5.054436s
              bluejay     12.462k (± 3.8%) i/s -     63.050k in   5.067804s

  Comparison:
              bluejay:    12462.0 i/s
              graphql:     1622.9 i/s - 7.68x  (± 0.00) slower

  Profiling Ruby memory allocations:
  Calculating -------------------------------------
              graphql    52.848k memsize (     0.000  retained)
                        460.000  objects (     0.000  retained)
                          12.000  strings (     0.000  retained)
              bluejay     5.216k memsize (    40.000  retained)
                          39.000  objects (     1.000  retained)
                          0.000  strings (     0.000  retained)

  Comparison:
              bluejay:       5216 allocated
              graphql:      52848 allocated - 10.13x more
  ```
</details>

<details>
  <summary>Parse + Execute (Ruby 3.2, YJIT disabled)</summary>

  ```
  Profiling IPS:
  Warming up --------------------------------------
              graphql    71.000  i/100ms
              bluejay     1.244k i/100ms
  Calculating -------------------------------------
              graphql    713.576  (± 2.0%) i/s -      3.621k in   5.076367s
              bluejay     12.395k (± 3.4%) i/s -     63.444k in   5.125595s

  Comparison:
              bluejay:    12394.9 i/s
              graphql:      713.6 i/s - 17.37x  (± 0.00) slower

  Profiling Ruby memory allocations:
  Calculating -------------------------------------
              graphql    52.848k memsize (    27.488k retained)
                        460.000  objects (   228.000  retained)
                          12.000  strings (    12.000  retained)
              bluejay     5.216k memsize (     1.128k retained)
                          39.000  objects (     8.000  retained)
                          0.000  strings (     0.000  retained)

  Comparison:
              bluejay:       5216 allocated
              graphql:      52848 allocated - 10.13x more
  ```
</details>

<details>
  <summary>Parse small (Ruby 3.2, YJIT enabled)</summary>

  ```
  Profiling IPS:
  Warming up --------------------------------------
              bluejay    43.448k i/100ms
              graphql     6.736k i/100ms
  Calculating -------------------------------------
              bluejay    412.117k (± 9.2%) i/s -      2.042M in   5.000504s
              graphql     60.058k (±12.4%) i/s -    296.384k in   5.020994s

  Comparison:
              bluejay:   412116.5 i/s
              graphql:    60058.0 i/s - 6.86x  (± 0.00) slower

  Profiling Ruby memory allocations:
  Calculating -------------------------------------
              bluejay     0.000  memsize (     0.000  retained)
                          0.000  objects (     0.000  retained)
                          0.000  strings (     0.000  retained)
              graphql     6.192k memsize (     4.176k retained)
                          70.000  objects (    58.000  retained)
                          6.000  strings (     6.000  retained)

  Comparison:
              bluejay:          0 allocated
              graphql:       6192 allocated - Infx more
  ```
</details>

<details>
  <summary>Parse small (Ruby 3.2, YJIT disabled)</summary>

  ```
  Profiling IPS:
  Warming up --------------------------------------
              bluejay    40.910k i/100ms
              graphql     5.170k i/100ms
  Calculating -------------------------------------
              bluejay    404.179k (± 9.1%) i/s -      2.005M in   5.006653s
              graphql     58.068k (± 4.4%) i/s -    294.690k in   5.088417s

  Comparison:
              bluejay:   404179.2 i/s
              graphql:    58068.0 i/s - 6.96x  (± 0.00) slower

  Profiling Ruby memory allocations:
  Calculating -------------------------------------
              bluejay     0.000  memsize (     0.000  retained)
                          0.000  objects (     0.000  retained)
                          0.000  strings (     0.000  retained)
              graphql     6.192k memsize (     0.000  retained)
                          70.000  objects (     0.000  retained)
                          6.000  strings (     0.000  retained)

  Comparison:
              bluejay:          0 allocated
              graphql:       6192 allocated - Infx more
  ```
</details>

<details>
  <summary>Parse large (Ruby 3.2, YJIT enabled)</summary>

  ```
  Profiling IPS:
  Warming up --------------------------------------
              bluejay   186.000  i/100ms
              graphql    25.000  i/100ms
  Calculating -------------------------------------
              bluejay      2.215k (± 1.6%) i/s -     11.160k in   5.039504s
              graphql    295.089  (±10.5%) i/s -      1.475k in   5.067081s

  Comparison:
              bluejay:     2215.1 i/s
              graphql:      295.1 i/s - 7.51x  (± 0.00) slower

  Profiling Ruby memory allocations:
  Calculating -------------------------------------
              bluejay     0.000  memsize (     0.000  retained)
                          0.000  objects (     0.000  retained)
                          0.000  strings (     0.000  retained)
              graphql     1.425M memsize (   928.624k retained)
                          16.001k objects (    13.044k retained)
                          50.000  strings (    50.000  retained)

  Comparison:
              bluejay:          0 allocated
              graphql:    1425400 allocated - Infx more
  ```
</details>

<details>
  <summary>Parse large (Ruby 3.2, YJIT disabled)</summary>

  ```
  Profiling IPS:
  Warming up --------------------------------------
              bluejay   219.000  i/100ms
              graphql    27.000  i/100ms
  Calculating -------------------------------------
              bluejay      2.016k (± 9.7%) i/s -     10.074k in   5.049408s
              graphql    231.603  (±11.7%) i/s -      1.161k in   5.085568s

  Comparison:
              bluejay:     2016.0 i/s
              graphql:      231.6 i/s - 8.70x  (± 0.00) slower

  Profiling Ruby memory allocations:
  Calculating -------------------------------------
              bluejay     0.000  memsize (     0.000  retained)
                          0.000  objects (     0.000  retained)
                          0.000  strings (     0.000  retained)
              graphql     1.425M memsize (     0.000  retained)
                          16.001k objects (     0.000  retained)
                          50.000  strings (     0.000  retained)

  Comparison:
              bluejay:          0 allocated
              graphql:    1425400 allocated - Infx more
  ```
</details>

<details>
  <summary>Parse + Validate (Ruby 3.2, YJIT enabled)</summary>

  ```
  Profiling IPS:
  Warming up --------------------------------------
              graphql   443.000  i/100ms
              bluejay     6.333k i/100ms
  Calculating -------------------------------------
              graphql      4.447k (± 2.2%) i/s -     22.593k in   5.083426s
              bluejay     62.372k (± 2.1%) i/s -    316.650k in   5.079131s

  Comparison:
              bluejay:    62372.2 i/s
              graphql:     4446.7 i/s - 14.03x  (± 0.00) slower

  Profiling Ruby memory allocations:
  Calculating -------------------------------------
              graphql    34.208k memsize (    12.440k retained)
                        396.000  objects (   157.000  retained)
                          17.000  strings (    13.000  retained)
              bluejay    40.000  memsize (    40.000  retained)
                          1.000  objects (     1.000  retained)
                          0.000  strings (     0.000  retained)

  Comparison:
              bluejay:         40 allocated
              graphql:      34208 allocated - 855.20x more
  ```
</details>

<details>
  <summary>Parse + Validate (Ruby 3.2, YJIT disabled)</summary>

  ```
  Profiling IPS:
  Warming up --------------------------------------
              graphql   240.000  i/100ms
              bluejay     5.107k i/100ms
  Calculating -------------------------------------
              graphql      2.000k (± 2.3%) i/s -     10.080k in   5.042715s
              bluejay     53.537k (±15.6%) i/s -    265.564k in   5.084180s

  Comparison:
              bluejay:    53537.2 i/s
              graphql:     2000.0 i/s - 26.77x  (± 0.00) slower

  Profiling Ruby memory allocations:
  Calculating -------------------------------------
              graphql    34.120k memsize (    12.560k retained)
                        394.000  objects (   160.000  retained)
                          15.000  strings (    13.000  retained)
              bluejay    40.000  memsize (    40.000  retained)
                          1.000  objects (     1.000  retained)
                          0.000  strings (     0.000  retained)

  Comparison:
              bluejay:         40 allocated
              graphql:      34120 allocated - 853.00x more
  ```
</details>

<details>
  <summary>Schema dump (Ruby 3.2, YJIT enabled)</summary>

  ```
  Profiling IPS:
  Warming up --------------------------------------
              graphql   255.000  i/100ms
              bluejay    16.141k i/100ms
  Calculating -------------------------------------
              graphql      2.527k (± 2.7%) i/s -     12.750k in   5.050419s
              bluejay    161.835k (± 1.7%) i/s -    823.191k in   5.088056s

  Comparison:
              bluejay:   161835.1 i/s
              graphql:     2526.5 i/s - 64.05x  (± 0.00) slower

  Profiling Ruby memory allocations:
  Calculating -------------------------------------
              graphql    57.528k memsize (     0.000  retained)
                        527.000  objects (     0.000  retained)
                          50.000  strings (     0.000  retained)
              bluejay   640.000  memsize (     0.000  retained)
                          1.000  objects (     0.000  retained)
                          1.000  strings (     0.000  retained)

  Comparison:
              bluejay:        640 allocated
              graphql:      57528 allocated - 89.89x more
  ```
</details>

<details>
  <summary>Schema dump (Ruby 3.2, YJIT disabled)</summary>

  ```
  Profiling IPS:
  Warming up --------------------------------------
              graphql   192.000  i/100ms
              bluejay    16.315k i/100ms
  Calculating -------------------------------------
              graphql      1.908k (± 2.1%) i/s -      9.600k in   5.035105s
              bluejay    161.043k (± 1.9%) i/s -    815.750k in   5.067302s

  Comparison:
              bluejay:   161043.4 i/s
              graphql:     1907.5 i/s - 84.43x  (± 0.00) slower

  Profiling Ruby memory allocations:
  Calculating -------------------------------------
              graphql    57.528k memsize (   944.000  retained)
                        527.000  objects (    12.000  retained)
                          50.000  strings (     4.000  retained)
              bluejay   640.000  memsize (     0.000  retained)
                          1.000  objects (     0.000  retained)
                          1.000  strings (     0.000  retained)

  Comparison:
              bluejay:        640 allocated
              graphql:      57528 allocated - 89.89x more
  ```
</details>

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add bluejay

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install bluejay

## Usage

See an example in the [`/example`](/example) directory. Note the usage of [Tapioca](https://github.com/Shopify/tapioca) RBI generation for the DSL at [`/example/sorbet/rbi/dsl/graph`](/example/sorbet/rbi/dsl/graph)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).
