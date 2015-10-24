class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @last()

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: (final) ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    if @isDealer and final
      dealerScore = @at(0).get('value') + @at(1).get('value')
      i = 2
      while dealerScore < 17 and @at(i)?
        dealerScore += @at(i).get('value')
        i++
      [dealerScore, dealerScore + 10 * @hasAce()]
    else
      [@minScore(), @minScore() + 10 * @hasAce()]

  stand: ->

    # player score is already calculated
      # choose greatest valid score if ace is present
    # trigger has to alert AppView that game has ended
      # compare player score to dealer score
      # alert who is winner
      # restart game with new deck or proceed to next round
