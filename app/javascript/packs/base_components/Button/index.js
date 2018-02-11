import React from 'react';
import PropTypes from 'prop-types';

import './styles.css';

const Button = ({ style, text, handleClick, children }) => {
  return (
    <button
      style={style}
      onClick={handleClick}
      className="Button"
      type="button"
    >
      {text}
      {children}
    </button>
  );
};

Button.propTypes = {
  text: PropTypes.string.isRequired,
  handleClick: PropTypes.func,
  style: PropTypes.object,
  children: PropTypes.element
};

export default Button;
