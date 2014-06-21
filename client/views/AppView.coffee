class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: ->
    @render()
    @model.on 'change', @render, @

  render: ->
    @$el.children().detach()
    if not @model.get 'winner'
      @$el.html @template()
    else
      @$el.html "<h1>The winner is #{@model.get 'winner'}</h1>" + '<div class="player-hand-container"></div><div class="dealer-hand-container"></div>'

    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el


  # displayWinner: (hand) ->
  #   if hand.isDealer then alert()
  #   alert "#{hand.isDealer}"

