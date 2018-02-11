import React, { Component } from 'react';

const modal = WrappedComponent => {
  return class Modal extends Component {
    constructor() {
      super();
      this.state = {
        showModal: false
      };
    }

    close = () => {
      this.setState({ showModal: false });
    };

    open = () => {
      this.setState({ showModal: true });
    };

    render() {
      return (
        <WrappedComponent
          {...this.props}
          onOpen={this.open}
          onClose={this.close}
          isOpen={this.state.showModal}
        />
      );
    }
  };
};

export default modal;
