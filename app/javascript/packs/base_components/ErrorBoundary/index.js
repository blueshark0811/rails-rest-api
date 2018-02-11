import React from 'react';
import PropTypes from 'prop-types';
import MediaQuery from 'react-responsive';

import Box from 'base_components/Box';

class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false };
  }

  componentDidCatch(error, info) {
    // Display fallback UI
    this.setState({ hasError: true });
    // You can also log the error to an error reporting service
    /* logErrorToMyService(error, info);*/
  }

  render() {
    const headlineStyle = {
      fontSize: '1.2rem',
      textAlign: 'center',
      fontFamily: 'Avenir Next',
      fontWeight: 500
    };

    if (this.state.hasError) {
      return (
        <Box>
          <MediaQuery query="(max-width: 767px)">
            <h3 style={headlineStyle}>{this.props.errMsg}</h3>
          </MediaQuery>
          <MediaQuery query="(min-width: 768px)">
            <h3
              style={{
                ...headlineStyle,
                marginTop: '2em',
                fontSize: '1.5rem'
              }}
            >
              {this.props.errMsg}
            </h3>
          </MediaQuery>
        </Box>
      );
    }

    return this.props.children;
  }
}

ErrorBoundary.propTypes = {
  errMsg: PropTypes.string.isRequired
};

export default ErrorBoundary;
