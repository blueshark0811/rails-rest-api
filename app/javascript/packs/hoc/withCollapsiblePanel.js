import React, { Component } from 'react';

// subscribing on this function makes your component handles a collapsible panel.
const withCollapsiblePanel = WrappedComponent => {
  class CollapsiblePanel extends Component {
    constructor(...args) {
      super(...args);
      this.state = {
        open: false
      };
    }

    // to toggle the state open.
    onToggle = () => this.setState({ open: !this.state.open });

    render() {
      return (
        <WrappedComponent
          {...this.props}
          onToggle={this.onToggle}
          isOpenPanel={this.state.open}
        />
      );
    }
  }

  return CollapsiblePanel;
};

export default withCollapsiblePanel;
