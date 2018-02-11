import React, { Component } from 'react';
import { isEmpty } from 'ramda';
import SpinnerUI from './components/SpinnerUI';

class Spinner extends Component {
  constructor() {
    super();
    this.state = {
      count: 1
    };
  }

  handleChange = e => {
    const { value } = e.target;
    this.setState({
      count: isEmpty(value) ? 0 : parseInt(value, 10)
    });
  };

  incrementCounter = () => {
    this.setState({
      count: this.state.count + 1
    });
  };

  decrementCounter = () => {
    this.setState({
      count: this.state.count - 1
    });
  };

  render() {
    return (
      <SpinnerUI
        count={this.state.count}
        onIncrementCounter={this.incrementCounter}
        onDecrementCounter={this.decrementCounter}
        onHandleChange={this.handleChange}
      />
    );
  }
}

export default Spinner;
