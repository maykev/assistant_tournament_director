class MatchPlayer extends React.Component {
    render () {
        let topLine;
        let bottomLine;

        if (this.props.matchPlayer.topLinePoints !== undefined) {
            topLine = <polyline points={this.props.matchPlayer.topLinePoints} />;
        }

        if (this.props.matchPlayer.bottomLinePoints !== undefined) {
            bottomLine = <polyline points={this.props.matchPlayer.bottomLinePoints} />;
        }

        console.log(this.props);
        return (
            <g>
                <rect
                  width={this.props.playerWidth}
                  height={this.props.height}
                  x={this.props.matchPlayer.x}
                  y={this.props.matchPlayer.y}
                />
                <text
                  width={this.props.playerWidth}
                  height={this.props.height}
                  x={this.props.matchPlayer.x + 5}
                  y={this.props.matchPlayer.y + this.props.height / 2 + 5}
                >
                    {this.props.matchPlayer.name}
                </text>
                <rect
                  width={this.props.scoreWidth}
                  height={this.props.height}
                  x={this.props.matchPlayer.x + this.props.playerWidth}
                  y={this.props.matchPlayer.y}
                />
                <text
                  width={this.props.scoreWidth}
                  height={this.props.height}
                  x={this.props.matchPlayer.x + this.props.playerWidth + 5}
                  y={this.props.matchPlayer.y + this.props.height / 2 + 5}
                >
                    {this.props.matchPlayer.score}
                </text>
                {topLine}
                {bottomLine}
            </g>
        );
    }
}

MatchPlayer.propTypes = {
    key: React.PropTypes.string,
    matchPlayer: React.PropTypes.object,
    playerWidth: React.PropTypes.number,
    scoreWidth: React.PropTypes.number,
    height: React.PropTypes.number
};
