assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null
  dealer = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    dealer = deck.dealDealer()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 48
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 47
