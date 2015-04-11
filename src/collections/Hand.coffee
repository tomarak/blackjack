class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, deck, isDealer) ->
    @flippedCard = array[0]
    @CardsAtHand = array
    @isDealer = isDealer || false
    @deck = deck
    @isStanding = false
    if !isDealer
      @isPlaying = true
    else @isPlaying = false

  hit: ->
    if @isPlaying and !@isStanding and @minScore() < 21
      @add(@deck.pop())
      @checkScore()


  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  stand: ->
    if !@isDealer
      @isPlaying = false
      @trigger('playerFinished', @)
      @isStanding = true

  dealerHit: ->
    while @minScore() < 17
      @hit()
    @trigger('declareWinner', @minScore(), @)

  startPlaying: ->
    if @isDealer
      @flippedCard = @flippedCard.flip()
      @isPlaying = true;
      @dealerHit()

  checkScore: ->
    if @minScore() == 21 && !@isDealer
      @stand()
    if @minScore() > 21 && !@isDealer
      @trigger('playerLoses', @)




