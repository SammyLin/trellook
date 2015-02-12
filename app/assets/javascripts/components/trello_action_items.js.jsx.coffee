###* @jsx React.DOM ###

R = React.DOM

TrelloActionItems = React.createClass(
  getInitialState: ->
    _this = this
    boards_count = 0
    tmp_items = []
    Trello.get 'members/me/boards', (boards) ->
      for board in boards
        Trello.get 'boards/' + board.id + '/actions?filter=commentCard', (actions) ->
          tmp_items = tmp_items.concat(actions)
          boards_count += 1
          if boards_count == boards.length
            tmp_items.sort _this.sortDescending
            _this.setState items: tmp_items
    {items: []}

  sortDescending: (a, b) ->
    new Date(b.date).getTime() - new Date(a.date).getTime()

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