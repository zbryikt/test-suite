require! <[fs fs-extra crypto assert path ../src/index puppeteer]>
# mocha use `it` which conflict with LiveScript `it` parameter.
that = it

screen-diff = do
  page-count: 0
  close-page: (page) ->
    @page-count--
    if @page-count > 0 => return
    @browser.close!then ~> @browser = null
  get-page: ->
    p = if @browser => Promise.resolve(that) else puppeteer.launch {headless: true, args: <[--no-sandbox]>}
    p
      .then (browser) ~>
        @page-count++
        @browser = browser
        browser.newPage!
  test: (opt = {}) -> ->
    @timeout opt.timeout or 5000
    screen-diff.get-page!.then (page) ->
      page.goto opt.url
        .then -> page.screenshot encoding: \binary
        .then (buf) ->
          fs-extra.ensure-dir-sync('.screendiff')
          fn = path.join('.screendiff', (opt.filename or 'out'))
          if fs.exists-sync fn =>
            r1 = crypto.createHash \md5 .update(fs.read-file-sync(fn)).digest \hex
          else
            r1 = null
            fs.write-file-sync fn, buf
          r2 = crypto.createHash \md5 .update(buf).digest \hex
          if r1 => assert.equal r1, r2
        .finally -> screen-diff.close-page page

describe \array, ->
  describe '#indexOf()', ->
    that "should return -1 when the value is not present", ->
      assert.equal [1,2,3].indexOf(4), -1

describe \return1, ->
  that "should return 1", ->
    assert.equal index.return1!, 1

describe \screen, ->
  that "should be the same", screen-diff.test({
    timeout: 5000
    url: "http://localhost:3000/"
    filename: "out.jpg"
  })


