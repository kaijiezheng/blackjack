class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<img src=<%= cardURL %>>'

  initialize: ->
    @render()
    @model.on 'flip', @render

  render: ->
    @$el.children().detach()
    url = if @model.get 'revealed' then "img/cards/" + @model.attributes.rankName.toString().toLowerCase() + "-" + @model.attributes.suitName.toString().toLowerCase() + ".png" else "img/card-back.png"
    @$el.html @template {cardURL: url}
    @$el.addClass 'covered' unless @model.get 'revealed'
