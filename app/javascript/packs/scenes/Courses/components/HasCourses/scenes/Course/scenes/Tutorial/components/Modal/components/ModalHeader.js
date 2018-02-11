import React from 'react';
import PropTypes from 'prop-types';
import Media from 'react-media';

import ModalBox from './ModalBox';
import ModalButton from './ModalButton';
import closeSrc from '../close-button.svg';

const ModalHeader = ({ handleCloseModal }) => {
  return (
    <Media query="(max-width: 767px)">
      {matches =>
        matches ? (
          <ModalBox
            style={{
              flexDirection: 'row-reverse',
              padding: '2% 3% 3% 3%'
            }}
          >
            <ModalButton
              handleClick={handleCloseModal}
              style={{
                padding: 0,
                fontSize: '1.2rem'
              }}
            >
              <img
                className="ModalButtonClose"
                alt="ButtonClose"
                src={closeSrc}
                style={{ height: 15 }}
              />
            </ModalButton>
          </ModalBox>
        ) : (
          <ModalBox
            style={{
              flexDirection: 'row-reverse',
              padding: '16px 35px'
            }}
          >
            <ModalButton
              handleClick={handleCloseModal}
              style={{
                padding: 0,
                fontSize: '1.2rem'
              }}
            >
              <img
                className="ModalButtonClose"
                alt="ButtonClose"
                src={closeSrc}
                style={{ height: 15 }}
              />
            </ModalButton>
          </ModalBox>
        )}
    </Media>
  );
};

ModalHeader.propTypes = {
  handleCloseModal: PropTypes.func.isRequired
};

export default ModalHeader;
