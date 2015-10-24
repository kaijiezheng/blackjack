class window.BlackjackView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="round-button hidden">New Round</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="alert hidden"></div>
  '

  events:
    'click .hit-button': (e) ->
      @model.get('playerHand').hit()
      @model.get('dealerHand').hit()
      @checkWinner(e)
    'click .stand-button': (e) ->
      @model.get('dealerHand').first().flip()
      @checkWinner(e)
    'click .round-button': (e) ->
      @model.set('deck', deck = new Deck()) if @model.get('deck').length <= 208
      @model.set('playerHand', @model.get('deck').dealPlayer())
      @model.set('dealerHand', @model.get('deck').dealDealer())
      @render()
      @checkWinner(e)

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  checkWinner: (e) ->
    playerScores = @model.get('playerHand').scores()
    if e.target.className == 'hit-button' or e.target.className == 'round-button'
      if playerScores[0] == 21 or playerScores[1] == 21
        @alertWinner 'player'
      else if playerScores[0] > 21 and playerScores[1] > 21
        @alertWinner 'dealer'
    else if e.target.className == 'stand-button'
      dealerScores = @model.get('dealerHand').scores(true)
      playerScore = 0
      dealerScore = 0
      if playerScores[1] < 21
        playerScore = playerScores[1]
      else
        playerScore = playerScores[0]

      if dealerScores[1] <= 21
        dealerScore = dealerScores[1]
      else
        dealerScore = dealerScores[0]
  
      console.log playerScores
      console.log dealerScores

      if dealerScore > playerScore and dealerScore <= 21
        @alertWinner 'Dealer'
      else
        @alertWinner 'Player'

  alertWinner: (winner) ->
    @$('.alert').text("#{winner}" + ' wins!')
    @$('.alert').removeClass('hidden')
    @$('.round-button').removeClass('hidden')
    @$('.hit-button').addClass('hidden')
    @$('.stand-button').addClass('hidden')