import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';

const Switch = styled(({ className, name }) => (
  <label className={className}>
    <input type="checkbox" name={name} />
    <span className="slider round" />
  </label>
))`
  position: relative;
  display: inline-block;
  width: 42px;
  height: 22px;
  margin-bottom: 0;

  input {
    width: 100%;
    height: 100%;
    visibility: hidden;
    margin: 0;
  }

  .slider {
    position: absolute;
    cursor: pointer;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: #ccc;
    -webkit-transition: 0.4s;
    transition: 0.4s;
  }

  .slider:before {
    position: absolute;
    content: '';
    height: 20px;
    width: 20px;
    left: 2px;
    bottom: 1px;
    background-color: white;
    -webkit-transition: 0.4s;
    transition: 0.4s;
  }

  input:checked + .slider {
    background-color: #2196f3;
  }

  input:focus + .slider {
    box-shadow: 0 0 1px #2196f3;
  }

  input:checked + .slider:before {
    -webkit-transform: translateX(19px);
    -ms-transform: translateX(19px);
    transform: translateX(19px);
  }

  /* Rounded sliders */
  .slider.round {
    border-radius: 34px;
  }

  .slider.round:before {
    border-radius: 50%;
  }
`;

Switch.propTypes = {
  name: PropTypes.string.isRequired,
  className: PropTypes.string
};

export default Switch;
