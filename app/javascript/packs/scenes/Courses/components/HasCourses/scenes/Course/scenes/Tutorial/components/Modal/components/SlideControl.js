import React from 'react';
import PropTypes from 'prop-types';

import ModalButton from './ModalButton';

const SlideControl = ({ text, arrow, handleClick }) => (
  <ModalButton style={{ padding: 0 }} handleClick={handleClick}>
    <span
      style={{
        marginRight: '0.3em'
      }}
    >
      {arrow}
    </span>
    <span>{text}</span>
  </ModalButton>
);

SlideControl.propTypes = {
  text: PropTypes.string.isRequired,
  arrow: PropTypes.string.isRequired,
  handleClick: PropTypes.func.isRequired
};

export default SlideControl;
