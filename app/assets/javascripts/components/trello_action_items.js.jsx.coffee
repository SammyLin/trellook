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
    R.div({className: 'mention_list' }, [
      for item in this.state.items
        regex = /^(@[a-z0-9]+)(?=$|\W)/
        if item.data.text.match regex
          `<div className='mention_warp'>
            <div className='mention_item'>
              <div className='memberCreator'>{item.memberCreator.fullName}</div>
              <div className='mention_main'><div className='mention_content'>{item.data.text}</div></div>
              <div className='mention_link'><a href={'https://trello.com/c/' + item.data.card.shortLink}>Permalink</a></div>
            </div>
          </div>`
      ])
)
window.TrelloActionItems = TrelloActionItems