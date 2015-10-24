class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @add _([0...416]).shuffle().map (card) ->
      new Card
        id: card
        rank: card % 13
        suit: Math.floor(card / 13) % 4

  dealPlayer: -> new Hand [@pop(), @pop()], @

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true

