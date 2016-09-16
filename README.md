# service-state-service

[![Dependency status](http://img.shields.io/david/octoblu/service-state-service.svg?style=flat)](https://david-dm.org/octoblu/service-state-service)
[![devDependency Status](http://img.shields.io/david/dev/octoblu/service-state-service.svg?style=flat)](https://david-dm.org/octoblu/service-state-service#info=devDependencies)
[![Build Status](http://img.shields.io/travis/octoblu/service-state-service.svg?style=flat)](https://travis-ci.org/octoblu/service-state-service)

[![NPM](https://nodei.co/npm/service-state-service.svg?style=flat)](https://npmjs.org/package/service-state-service)

# Table of Contents

* [Introduction](#introduction)
* [Getting Started](#getting-started)
  * [Install](#install)
* [Usage](#usage)
  * [Default](#default)
  * [Docker](#docker)
    * [Development](#development)
    * [Production](#production)
  * [Debugging](#debugging)
  * [Test](#test)
* [License](#license)

# Introduction

...

# Getting Started

## Install

```bash
git clone https://github.com/octoblu/service-state-service.git
cd /path/to/service-state-service
npm install
```

# Usage

## Default

```javascript
node command.js
```

## Docker 

### Development

```bash
docker build -t local/service-state-service .
docker run --rm -it --name service-state-service-local -p 8888:80 local/service-state-service
```

### Production

```bash
docker pull quay.io/octoblu/service-state-service
docker run --rm -p 8888:80 quay.io/octoblu/service-state-service
```

## Debugging

```bash
env DEBUG='service-state-service*' node command.js
```

```bash
env DEBUG='service-state-service*' node command.js
```

## Test 

```bash
npm test
```

## License

The MIT License (MIT)

Copyright (c) 2016 Octoblu

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
