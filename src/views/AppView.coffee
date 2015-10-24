class window.AppView extends Backbone.View
  initialize: ->
    @render
  render: ->
    new BlackjackView(model: @model.get('game'))
