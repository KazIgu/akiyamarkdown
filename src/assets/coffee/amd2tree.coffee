$ = require 'jquery'

Amd2Tree = () ->
  id = ID
  $editor = $("#editor#{id}")
  amd2tree = () ->

    if Editors.length == 0
      return

    $editor.addClass 'has-tree'

    editor = ace.edit("editor#{id}")
    _text = editor.getValue()
    tree = "graph LR\n"
    texts = _text.split '\n'
    parent = {}

    for text, i in texts
      # Subtitle
      if text.match /^(　+)?■(.*)/gm
        subtitle = text.replace(/^(　+)?■/, '')

      # Smalltitle
      if text.match /^(　+)?・(.*)/gm
        smalltitle = text.replace(/^(　+)?・/, '')
        tree += """
          #{subtitle} ==> #{smalltitle}\n
        """

      # Indent
      if text.match /^(　+)?→(.*)/gm
        indent = text.match(/^(　+)?/gm)[0].length
        # 下層
        if texts[i - 1].match(/^(　+)?/gm)[0].length < indent
          # 親がsmalltitle
          if texts[i - 1].match /^(　+)?・(.*)/gm
            indentText = text.replace(/^(　+)?→/,'')
            tree += """
              #{smalltitle} -.-> #{indentText}\n
            """
            parent[indent] = "#{smalltitle}"
          # 親がindent
          else
            tree += """
              #{texts[i - 1].replace(/^(　+)?→/,'')} -.-> #{text.replace(/^(　+)?→/,'')}\n
            """
            parent[indent] = "#{texts[i - 1].replace(/^(　+)?→/,'')}"
        # 並列
        else
          tree += """
            #{parent[indent]} -.-> #{text.replace(/^(　+)?→/,'')}\n
          """


    $mermaid = $("<div id='mermaid#{id}' class='mermaid'/>")

    if !$editor.find('.mermaid').length
      $editor.append $mermaid

      mermaidAPI.initialize
        startOnLoad: false
        flowchart:
          useMaxWidth: false

    if tree.replace("graph LR\n", '').length > 0
      mermaidAPI.render "mermaidRender#{Date.now().toString()}", tree, (html) ->
        $("#mermaid#{id}").html html


    return


  if $editor.hasClass 'has-tree'
    $('textarea').off '.amd2tree'
    $editor.removeClass 'has-tree'
    $('.mermaid').remove()
    return

  $('textarea').on 'keyup.amd2tree', () ->
    amd2tree()
  amd2tree()

module.exports = Amd2Tree