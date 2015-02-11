###* @jsx React.DOM ###

LoginButton = React.createClass(
  render: ->
    `<a href="#" onClick={this.props.onButtonClicked} className="login_link">Login Trello</a>`
)
LogoutButton = React.createClass(
  render: ->
    `<a href="#" onClick={this.props.onButtonClicked}>Log Out</a>`
)

Trellook = React.createClass(
  getInitialState: ->
    isConnect = false
    Trello.authorize
      interactive: false
      success: ->
        isConnect = true
    { connect_state: isConnect }
  handleToggle: ->
    _this = this
    Trello.authorize
      type: "popup"
      persist: false
      expiration: "1hour"
      name: "Trellook"
      success: ->
        _this.setState({connect_state: true})
  handleLogout: ->
    Trello.deauthorize()
    this.setState connect_state: false
  render: ->
    _this = this
    if @state.connect_state is true
      `<div>
        <TrelloActionItems />
        <LogoutButton onButtonClicked={_this.handleLogout} />
      </div>
      `
    else
      `<div className="welcome">
          <div className="text-vertical-center">
            <div className="header">
              Trellook
            </div>
            <div className="login">
              <LoginButton onButtonClicked={_this.handleToggle} />
            </div>
          </div>
        </div>`
)

window.Trellook = Trellook