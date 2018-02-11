import React from 'react';
import PropTypes from 'prop-types';
import Media from 'react-media';

const ModalInner = ({ children }) => (
  <Media query="(max-width: 767px)">
    {matches =>
      matches ? (
        <div
          style={{
            backgroundColor: '#fff'
          }}
        >
          {children}
        </div>
      ) : (
        <div
          style={{
            backgroundColor: '#fff'
          }}
        >
          {children}
        </div>
      )}
  </Media>
);

ModalInner.propTypes = {
  children: PropTypes.arrayOf(PropTypes.element).isRequired
};

export default ModalInner;
