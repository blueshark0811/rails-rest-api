import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';

const ButtonLogout = styled(({ className, handlerClick }) => (
  <li className={className}>
    <button onClick={handlerClick}>Logout</button>
  </li>
))`
  padding: 0.5em;

  button {
    background: none;
    border: 0;
    transition: all 300ms ease-in;

    &:hover {
      color: rgb(14, 144, 224);
    }
  }
`;

ButtonLogout.propTypes = {
  handlerClick: PropTypes.func.isRequired
};

export default ButtonLogout;
