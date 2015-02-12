###* @jsx React.DOM ###

LoginButton = React.createClass(
  render: ->
    `<a href="#" onClick={this.props.onButtonClicked} className="login_link">Login Trello</a>`
)
Navbar = React.createClass(
  render: ->
    `<div className='navbar_warp'>
      <div className='navber'>
        <div className='logo'>Trellook</div>
        <div className='logout'><LogoutButton onButtonClicked={this.props.onButtonClicked}/></div>
      </div>
    </div>`
)
LogoutButton = React.createClass(
  render: ->
    `<a href="#" onClick={this.props.onButtonClicked}><i className='fa fa-sign-out'></i></a>`
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
      expiration: "1hour"
      name: "Trellook"
      success: ->
        _this.setState({connect_state: true})
  handleLogout: ->
    Trello.deauthorize()
    location.reload()
  render: ->
    _this = this
    if @state.connect_state is true
      `<div>
        <TrelloActionItems />
        <Navbar onButtonClicked={_this.handleLogout} />
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