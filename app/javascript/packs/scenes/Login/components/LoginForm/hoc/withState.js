import React, { Component } from 'react';

export default WrappedComponent => {
  class EnhancedLoginForm extends Component {
    state = {
      username: '',
      password: ''
    };

    handleChange = e => {
      const { value, name } = e.target;

      // update the state
      this.setState({
        [name]: value
      });
    };

    clearForm = () => {
      // TODO: add auto-focus feature.
      this.setState({
        username: '',
        password: ''
      });
    };

    render() {
      const { username, password } = this.state;

      return (
        <WrappedComponent
          {...this.props}
          onHandleChange={this.handleChange}
          clearForm={this.clearForm}
          username={username}
          password={password}
        />
      );
    }
  }

  return EnhancedLoginForm;
};
