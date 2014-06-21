#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    playerHand = @get 'playerHand'
    dealerHand = @get 'dealerHand'

    playerHand.on 'bust', (hand) ->
      alert "you lose, sucker! your score is #{hand.scores()[0]}"

    playerHand.on 'blackjack', (hand) ->
      alert "Winner winner chicken dinner!"

    playerHand.on 'stand', (hand) =>
      @playDealer()

    dealerHand.on 'bust', (hand) ->
      alert "Dealer busted. You win!"

    dealerHand.on 'blackjack', (hand) ->
      alert "Dealer kicked yo ass! Backjack!"

    dealerHand.on 'stand', (hand) =>
      alert "Dealer is standing. Who wins?"

  playDealer: ->
    dealerHand = @get 'dealerHand'
    dealerHand.revealCards()
    while @dealerScore() < 17
      dealerHand.hit()

    if  16 < do @dealerScore < 21
      dealerHand.stand()

  dealerScore: ->
    dealerHand = @get 'dealerHand'
    scores = dealerHand.scores()
    if ( scores[1] and scores[1] < 21)
      return scores[1]
    else
      return scores[0]


    ## this.get('playerHand').on('win', function(){
    # something awesome
    #})
    #
  #gameover
    # on(changes on hand){
    #
    #  }}
