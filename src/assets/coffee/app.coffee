remote = require 'remote'
dialog = remote.require 'dialog'
browserWindow = remote.require 'browser-window'
Menu = remote.require 'menu'
MenuItem = remote.require 'menu-item'
app = remote.require 'app'

fs = require 'fs'
$ = require 'jquery'
require 'ace-min-noconflict'
require 'ace-min-noconflict/theme-monokai'
require './assets/javascripts/syntax'
# -------------------------
# Menu
# -------------------------
menu = Menu.buildFromTemplate require './assets/javascripts/menu'
Menu.setApplicationMenu menu


# -------------------------
# Editor
# -------------------------
editor = ace.edit("editor")
editor.setTheme("ace/theme/monokai")
editor.getSession().setMode("ace/mode/amd")
editor.getSession().setOptions
 useSoftTabs: false
editor.getSession().setTabSize(2)
editor.getSession().on 'change', (e) ->
  if e.data.text == "\n"
    range = e.data.range
    beforeText = editor.getSession().getLine range.start.row
