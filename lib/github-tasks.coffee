GithubTasksView = require './github-tasks-view'
{CompositeDisposable} = require 'atom'

module.exports = GithubTasks =
  githubTasksView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @githubTasksView = new GithubTasksView(state.githubTasksViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @githubTasksView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'github-tasks:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @githubTasksView.destroy()

  serialize: ->
    githubTasksViewState: @githubTasksView.serialize()

  toggle: ->
    console.log 'GithubTasks was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
