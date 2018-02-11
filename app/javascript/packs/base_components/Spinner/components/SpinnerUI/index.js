import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';
//
import ContainerFlex from 'base_components/ContainerFlex';
import IconCaretLeft from 'react-icons/lib/fa/caret-left';
import IconCaretRight from 'react-icons/lib/fa/caret-right';

const ContainerSpinner = ContainerFlex.extend`
  width: 98px;
  height: 34px;
  border: 1px solid #d8d8d8;
  border-radius: 3px;
  padding: 6px 12px;
  color: #000000;
`;

const ButtonSpinner = styled.button`
  border: 0;
  background: transparent;
  padding: 0;
  cursor: pointer;
`;

const TextSpinner = styled.input`
  width: 46px;
  border: 0;
  text-align: center;
`;

const SpinnerUI = ({
  onDecrementCounter,
  onIncrementCounter,
  count,
  onHandleChange
}) => (
  <ContainerSpinner isAlignCenter isSpaceBetween>
    <ButtonSpinner onClick={onDecrementCounter}>
      <i>
        <IconCaretLeft />
      </i>
    </ButtonSpinner>
    <TextSpinner
      name="counter"
      type="text"
      onChange={onHandleChange}
      value={count}
    />
    <ButtonSpinner onClick={onIncrementCounter}>
      <i>
        <IconCaretRight />
      </i>
    </ButtonSpinner>
  </ContainerSpinner>
);

SpinnerUI.propTypes = {
  /* count: PropTypes.number.isRequired,*/
  onIncrementCounter: PropTypes.func.isRequired,
  onDecrementCounter: PropTypes.func.isRequired,
  onHandleChange: PropTypes.func.isRequired
};

export default SpinnerUI;
