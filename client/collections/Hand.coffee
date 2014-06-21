class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->


  hit: ->
    @add(@deck.pop()).last()
    if @bestScore() > 21 then @trigger 'bust', @
    @checkBlackjack()

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  stand: ->
    @trigger 'stand', @

  checkBlackjack: ->
    if (@bestScore() is 21) then @trigger 'blackjack', @

  revealCards: ->
    _.each @models, (card) ->
      if not card.get 'revealed' then card.flip()

  bestScore: ->
    scores = @scores()
    if ( scores[1] and scores[1] <= 21)
      return scores[1]
    else
      return scores[0]


