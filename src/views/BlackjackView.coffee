class window.BlackjackView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': (e) ->
      @model.get('playerHand').hit()
      @model.get('dealerHand').hit()
      @checkWinner(e)
    'click .stand-button': (e) ->
      @model.get('dealerHand').first().flip()
      setTimeout(@checkWinner.bind(@, e), 1000)

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  checkWinner: (e) ->
    playerScores = @model.get('playerHand').scores()
    if e.target.className == 'hit-button'
      if playerScores[0] == 21 or playerScores[1] == 21
        @alertWinner 'player'
      else if playerScores[0] > 21 and playerScores[1] > 21
        @alertWinner 'dealer'
    else # if e.target.className == 'stand-button'
      dealerScores = @model.get('dealerHand').scores(true)
      playerScore = 0
      dealerScore = 0
      if playerScores[1] < 21
        playerScore = playerScores[1]
      else
        playerScore = playerScores[0]

      if dealerScores[0] > 21
        @alertWinner 'player'

      if dealerScores[1] <= 21
        dealerScore = dealerScores[1]
      else
        dealerScore = dealerScores[0]
  
      if playerScore >= dealerScore
        @alertWinner 'player' 
      else
        @alertWinner 'dealer'

  alertWinner: (winner) ->
    alert "#{winner} wins the game!"