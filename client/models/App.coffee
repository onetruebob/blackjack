#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    playerHand = @get 'playerHand'
    dealerHand = @get 'dealerHand'

    playerHand.on 'bust', (hand) =>
      @set 'winner', 'dealer'
      @set 'playerStance', 'bust'

    playerHand.on 'blackjack', (hand) =>
      @set 'winner', 'player'
      @set 'playerStance', 'blackjack'

    playerHand.on 'stand', (hand) =>
      @set 'placerStance', 'stand'
      @playDealer()

    dealerHand.on 'bust', (hand) =>
      @set 'winner', 'player'
      @set 'dealerStance', 'bust'

    dealerHand.on 'blackjack', (hand) =>
      @set 'winner', 'dealer'
      @set 'dealerStance', 'blackjack'

    dealerHand.on 'stand', (hand) =>
      @set 'dealerStance', 'stand'
      @checkWinner()

    playerHand.checkBlackjack()

  playDealer: ->
    dealerHand = @get 'dealerHand'
    dealerHand.revealCards()
    dealerHand.checkBlackjack()
    while @dealerScore() < 17
      dealerHand.hit()

    if  16 < do @dealerScore < 21
      dealerHand.stand()

  dealerScore: ->
    dealerHand = @get 'dealerHand'
    dealerHand.bestScore()

  checkWinner: ->
    playerScore = (@get 'playerHand').bestScore()
    dealerScore = (@get 'dealerHand').bestScore()
    if (playerScore > dealerScore) then @set 'winner', 'player' else @set 'winner', 'dealer'


    ## this.get('playerHand').on('win', function(){
    # something awesome
    #})
    #
  #gameover
    # on(changes on hand){
    #
    #  }}
