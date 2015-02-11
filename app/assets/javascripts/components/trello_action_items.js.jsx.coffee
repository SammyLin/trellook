###* @jsx React.DOM ###

R = React.DOM

TrelloActionItems = React.createClass(
  getInitialState: ->
    _this = this
    Trello.get 'members/me/boards', (boards) ->
      for board in boards
        Trello.get 'boards/' + board.id + '/actions?filter=commentCard', (actions) ->
          _this.setState items: _this.state.items.concat(actions)
    {items: []}
  render: ->
    R.ul({}, [
      for item in this.state.items
        regex = /^(@[a-z0-9]+)(?=$|\W)/
        if item.data.text.match regex
          `<li>{item.memberCreator.fullName} Say {item.data.text} - <a href={'https://trello.com/c/' + item.data.card.shortLink}>連結</a></li>`
      ])
)
window.TrelloActionItems = TrelloActionItems