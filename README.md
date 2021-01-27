# test-suite ( moved to plotdb/practices )

guide to do testing in different scenario.


## Basic Setup

We use following stack for testing:

 * `mocha` - flexible test framework
   - `sinonjs` - test spy ( recording args, retval, value of this and exception thrown of a function )
   - `mochawesome` - report generator 
     mocha --reporter mochawesome
   - `assert` - mocha let you choose your own assert lib. for a quick choice, use node.js core lib `assert` directly.
   - `instanbul` - test coverage

install ( mocha, mochawesome, instanbul ):

    npm install --save-dev mocha mochawesome nyc


## Test in NodeJS

test code: 

    require! <[assert]>
    # mocha use `it` which conflict with LiveScript `it` parameter.
    that = it
    describe \array, ->
      describe '#indexOf()', ->
        that "should return -1 when the value is not present", ->
          assert.equal [1,2,3].indexOf(4), -1
    describe \deepequal, ->
      that "should equal", ->
        assert.deepStrictEqual {a: NaN}, {a: NaN}

run test with livescript:

    ./node_modules/.bin/mocha --require livescript ./test/index.ls


## Test Coverage

 * use instanbul
   - https://stackoverflow.com/questions/16633246/code-coverage-with-mocha
   - https://medium.com/@asemiloore/nodejs-testing-with-mocha-and-code-coverage-with-nyc-9d1d6e428ac1
 * config in package.json:
    "nyc": {
      "all": true,
      "extension": ".ls",
      "require": ["livescript"],
      "include": ["src/**/*"]
    }
 * sample run script:
    "test": "./node_modules/.bin/mocha --require livescript ./test/index.ls",
    "cover": "./node_modules/.bin/nyc --reporter=text  npm run test"
 * run in browser
   - https://github.com/gotwarlost/istanbul/issues/16
   - https://blog.engineyard.com/measuring-clientside-javascript-test-coverage-with-istanbul

