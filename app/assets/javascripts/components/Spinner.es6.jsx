'use strict';

class Spinner extends React.Component {
    render() {
        let style = {
            marginTop: 14,
            marginBottom: 14,
            textAlign: 'center'
        }

        return (
            <div style={style}>
                <i className="fa fa-refresh fa-spin"></i>
            </div>
        )
    }
}

// pass in styles for customization
Spinner.propTypes = {}
