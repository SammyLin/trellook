###* @jsx React.DOM ###

R = React.DOM

TrelloActionItems = React.createClass(
  getInitialState: ->
    _this = this
    tmp_items = []
        # token: Trello.token).done (actions) ->
    request = $.ajax(
      url: '/get_notifications'
      type: 'POST'
      data:
        token: Trello.token)
    request.done (actions) ->
      tmp_items = actions
      tmp_items.sort _this.sortDescending
      _this.setState items: tmp_items
    request.fail (jqXHR, textStatus) ->
      Trello.deauthorize()
      location.reload()
    {items: []}

    # this.hide()
    # $.post 'ajax/test.html', (data) ->
    #   $('.result').html data
# handleRemoveCommentClick = (e) ->
#   that = this
#   el = $(e.target)
#   el.text 'Removing...'
#   deleteCommentPromise = @api.deleteComment(@props)
#   deleteCommentPromise.done ->
#     if _.isFunction(that.props.onCommentRemove)
#       that.props.onCommentRemove that.props
#     return
#   return
  sortDescending: (a, b) ->
    new Date(b.date).getTime() - new Date(a.date).getTime()

  render: ->
    R.div({className: 'mention_list' }, [
      for item in this.state.items
        `<div className='mention_warp'>
          <div className='mention_item'>
            <div className='memberCreator'>{item.memberCreator.fullName}</div>
            <div className='mention_main'><div className='mention_content'>{item.data.text}</div></div>
          </div>
        </div>`
      ])
)
window.TrelloActionItems = TrelloActionItems