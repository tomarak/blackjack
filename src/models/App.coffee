# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    `this.get('playerHand').on('playerFinished', function() {
      this.get('dealerHand').startPlaying();
    },this);`

    `this.get('dealerHand').on('declareWinner', function(dealerScore) {

      var playerScore = this.get('playerHand').minScore();
      if (dealerScore > 21 || playerScore > dealerScore)
        this.trigger('playerWins', 'playerWins', this);

      else if (playerScore < dealerScore)
        this.trigger('dealerWins', 'dealerWins', this);

      else this.trigger('push', 'push', this);

    }, this);`

    `this.get('playerHand').on('playerLoses', function() {
      this.trigger('dealerWins', 'dealerWins', this);
      }
    , this);`



  stand: ->
    @get('dealerHand').stand()
