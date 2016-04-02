KleninView = require './klenin-view'
{CompositeDisposable} = require 'atom'

module.exports = Klenin =
  kleninView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @kleninView = new KleninView(state.kleninViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @kleninView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'klenin:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @kleninView.destroy()

  serialize: ->
    kleninViewState: @kleninView.serialize()

  toggle: ->
    console.log 'Klenin was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
