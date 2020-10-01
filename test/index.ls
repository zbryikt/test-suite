require! <[assert ../src/index]>
# mocha use `it` which conflict with LiveScript `it` parameter.
that = it
describe \array, ->
  describe '#indexOf()', ->
    that "should return -1 when the value is not present", ->
      assert.equal [1,2,3].indexOf(4), -1

describe \return1, ->
  that "should return 1", ->
    assert.equal index.return1!, 1
