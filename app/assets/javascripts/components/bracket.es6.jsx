class Bracket extends React.Component {
    render() {
        let self = this;

        return (
            <svg width="10000px" height="10000px">
                { self.props.tournamentMatchPlayers.map(function(matchPlayer){
                    return (
                        <MatchPlayer
                          key={matchPlayer.bracketPosition}
                          matchPlayer={matchPlayer}
                          playerWidth={self.props.playerWidth}
                          scoreWidth={self.props.scoreWidth}
                          height={self.props.height}
                        />
                    );
                })}
            </svg>
        );
    }
}

Bracket.propTypes = {
    playerWidth: React.PropTypes.number,
    scoreWidth: React.PropTypes.number,
    height: React.PropTypes.number,
    tournamentMatchPlayers: React.PropTypes.array
};
