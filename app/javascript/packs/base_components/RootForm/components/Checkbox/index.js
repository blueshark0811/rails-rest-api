import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';

// for checkbox
const Checkbox = styled(({ name, className }) => (
  <div className={className}>
    <input className="Checkbox" name={name} type="checkbox" />
    <label className="Checkbox__label" htmlFor={name} />
  </div>
))`
  width: 15px;
  height: 15px;
  position: relative;

  .Checkbox {
    position: relative;
    opacity: 0;
    z-index: 1;
    height: 100%;
    width: 100%;
    cursor: pointer;
  }

  .Checkbox:checked + .Checkbox__label {
    background-color: #338ffc;
    border-color: #338ffc;
  }

  .Checkbox:checked + .Checkbox__label:after {
    opacity: 1;
  }

  .Checkbox__label {
    background-color: transparent;
    border: 2px solid #cccccc;
    border-radius: 2px;
    left: 0;
    position: absolute;
    top: 0;
    height: 100%;
    width: 100%;

    &:after {
      border: 2px solid #fff;
      border-top: none;
      border-right: none;
      content: '';
      height: 5px;
      width: 9px;
      opacity: 0;
      position: absolute;
      top: 2px;
      left: 1px;
      transform: translate(-50%, -50%);
      -webkit-transform: rotate(-45deg);
      -ms-transform: rotate(-45deg);
      transform: rotate(-45deg);
    }
  }
`;

Checkbox.propTypes = {
  name: PropTypes.string.isRequired,
  className: PropTypes.string
};

const CheckboxCircle = styled(({ name, className }) => (
  <div className={className}>
    <input className="Checkbox" name={name} type="checkbox" />
    <label className="Checkbox__label" htmlFor={name} />
  </div>
))`
  display: inline-block;
  width: 20px;
  height: 20px;
  position: relative;
  border-radius: 50%;
  border: 2px solid #bbbbbb;

  .Checkbox {
    position: relative;
    opacity: 0;
    z-index: 1;
    height: 100%;
    width: 100%;
    cursor: pointer;
  }

  .Checkbox:checked + .Checkbox__label {
    background-color: #bbbbbb;
    border-color: #bbbbbb;
  }

  .Checkbox:checked + .Checkbox__label:after {
    opacity: 1;
  }

  .Checkbox__label {
    background-color: transparent;
    border-radius: 50%;
    left: 2px;
    position: absolute;
    top: 2px;
    height: 75%;
    width: 75%;
  }
`;

CheckboxCircle.propTypes = {
  name: PropTypes.string.isRequired,
  className: PropTypes.string
};

const CheckboxCircleSecondary = styled(({ name, className }) => (
  <div className={className}>
    <input className="Checkbox" name={name} type="checkbox" />
    <label className="Checkbox__label" htmlFor={name} />
  </div>
))`
  width: 25px;
  height: 25px;
  position: relative;

  .Checkbox {
    position: relative;
    opacity: 0;
    z-index: 1;
    height: 100%;
    width: 100%;
    cursor: pointer;
    margin: 0;
  }

  .Checkbox:checked + .Checkbox__label:after {
    opacity: 1;
  }

  .Checkbox__label {
    background-color: transparent;
    border: 1px solid #bbbbbb;
    border-radius: 50%;
    left: 0;
    position: absolute;
    top: 0;
    height: 100%;
    width: 100%;

    &:after {
      border: 1px solid #000000;
      border-top: none;
      border-right: none;
      content: '';
      height: 5px;
      width: 12px;
      opacity: 0;
      position: absolute;
      top: 8px;
      left: 6px;
      transform: translate(-50%, -50%);
      -webkit-transform: rotate(-45deg);
      -ms-transform: rotate(-45deg);
      transform: rotate(-45deg);
    }
  }
`;

CheckboxCircleSecondary.propTypes = {
  name: PropTypes.string.isRequired
};

export { Checkbox, CheckboxCircle, CheckboxCircleSecondary };
