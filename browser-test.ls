require! <[puppeteer]>

lc = {}
puppeteer.launch {headless: true, args: <[--no-sandbox]>}
  .then (browser) ->
    lc.browser = browser
    browser.newPage!
  .then (page) ->
    lc.page = page
    page.on \console, (msg) -> for m in msg._args => console.log m.toString!
    console.log "goto..."
    new Promise (res, rej) ->
      lc.page.expose-function \report, -> res it
      lc.page.goto \http://localhost:3000
  .then ->
    console.log it
  .then ->
    lc.browser.close!

