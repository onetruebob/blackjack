assert = chai.assert

before ->
  @triggerSpy = sinon.spy Hand.prototype, 'trigger'



describe "Hand Check", ->

  it "should recognize when the player has Blackjack", ->
    @triggerSpy.reset()
    playerHand = new Hand [ new Card({ rank: 1 }), new Card({ rank: 10 }) ]
    do playerHand.checkBlackjack
    assert.isTrue @triggerSpy.calledWith 'blackjack'

  it "should recognize when the player has busted", ->
    @triggerSpy.reset()
    playerHand = new Hand [ new Card({ rank: 10 }), new Card({ rank: 10 })], new Deck()
    do playerHand.hit
    assert.isTrue @triggerSpy.calledWith 'bust'

  it "should recognize when the player stands", ->
    @triggerSpy.reset()
    playerHand = new Hand [ new Card({ rank: 10 }), new Card({ rank: 10 })]
    do playerHand.stand
    assert.isTrue @triggerSpy.calledWith 'stand'


