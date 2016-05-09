class Tournament extends React.Component {
    constructor() {
        super();

        this.state = {
            isFetching: true
        }
    }

    componentWillMount() {
        let self = this;

        $.get('/api/tournaments/' + this.props.id)
        .done(function(data) {
            console.log(data);
            self.setState({
                isFetching: false,
                name: data.name,
                playerWidth: data.playerWidth,
                scoreWidth: data.scoreWidth,
                height: data.height,
                lineLength: data.lineLength,
                tournamentMatchPlayers: data.tournamentMatchPlayers
            })
        })
        .fail(function(err) {
            self.setState({
                error: err
            })
        });
    }

    showTournament() {
        return (
            <div className="tournament">
                <h1>{this.state.name}</h1>
                <Bracket
                  tournamentMatchPlayers={this.state.tournamentMatchPlayers}
                  playerWidth={this.state.playerWidth}
                  scoreWidth={this.state.scoreWidth}
                  height={this.state.height}
                />
            </div>
        );
    }

    render() {
        let content = this.state.isFetching ? <Spinner /> : this.showTournament();

        return (
            <div>
                {content}
            </div>
        );
    }
}

Tournament.propTypes = {
  id: React.PropTypes.number
};
