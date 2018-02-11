import React from 'react';

import './styles.css';

class Form extends React.Component {
  constructor() {
    super();
    this.state = {
      complete: false
    };
  }

  handleInputChange = e => {
    const { target } = e;
    // check if the target is checkbox or text
    const value = target.type === 'checkbox' ? target.checked : target.value;
    // we need to get the name value attribute of the target.
    const name = target.name;
    // update the state based on the target
    this.setState({
      [name]: value
    });
  };

  render() {
    return (
      <form className="Form" action="">
        <div className="Form__Group--round">
          <input
            checked={this.state.complete}
            onChange={this.handleInputChange}
            name="complete"
            type="checkbox"
          />
          <label htmlFor="complete" />
        </div>
      </form>
    );
  }
}

export default Form;

export const fetchUser = () => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      reject(() => {
        throw new Error('Rejected by the server');
      });
    }, 500);
  });
};
