# Invoices Requester

Service to obtain invoices from a client in a time interval.


# Software instructions

You can execute the solution over Docker or on your own Ruby environment:

## For Docker

* Build image

```
$ docker build -t wvalencia19/invoicerequester:latest .
```

* Run main class
```
$  docker run wvalencia19/invoicerequester ruby main.rb 4e25ce61-e6e2-457a-89f7-116404990967 2017-1-1 2017-12-31
"Found 1173 invoices in 18 calls for customer 4e25ce61-e6e2-457a-89f7-116404990967"
```

* Run tests
```
$ docker run wvalencia19/invoicerequester rspec
```

## For Ruby environment

* Install rspec gem

```
bundle install
```

* Run main class

```
$ ruby main.rb 4e25ce61-e6e2-457a-89f7-116404990967 2017-1-1 2017-12-31
"Found 1173 invoices in 18 calls for customer 4e25ce61-e6e2-457a-89f7-116404990967"
```

* Run tests

```
$ rspec

```

## Design considerations

* In order to have production-ready code, docker configuration was included.
* The way to obtain invoices is based on the binary search algorithm.
* The solution applies the [reducing coupling](https://www.martinfowler.com/ieeeSoftware/coupling.pdf) principle,
the main idea is to be able change the way to obtain the invoices without have a big impact on customer class.


## Style guide 

This code was made following rubocop style guide for ruby:

* [Rubocop style guide](https://github.com/rubocop-hq/ruby-style-guide)
