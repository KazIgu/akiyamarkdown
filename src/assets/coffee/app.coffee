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

editor.commands.addCommand
  name: 'child'
  bindKey:
    mac: 'Shift-Enter'
  exec: (editor) ->
    cursor = editor.selection.getCursor()
    text = editor.getSession().getLine cursor.row
    indent = text.match /(　)*/g
    indent = indent[0].length
    indentText = ""
    for i in [0...indent]
      indentText += "　"
    target = 
      row: cursor.row
      column:  text.length

    # title
    if text.match /【(.*?)】/
      editor.session.insert target, "\n#{indentText}■"

    # subtitle
    if text.match /■(.*)/
      editor.session.insert target, "\n#{indentText}　・"

    # smalltitle
    if text.match /・(.*)/
      editor.session.insert target, "\n#{indentText}　→"

    # smalltitle
    if text.match /→(.*)/
      editor.session.insert target, "\n#{indentText}→"

editor.focus()