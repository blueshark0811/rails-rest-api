import React from 'react';
import PropTypes from 'prop-types';
import Media from 'react-media';

import Box from 'base_components/Box';

const ModalBox = ({ className, children, style }) => (
  <Media query="(max-width: 767px)">
    {matches =>
      matches ? (
        <Box
          className={className}
          style={{
            padding: '3%',
            display: 'flex',
            ...style
          }}
        >
          {children}
        </Box>
      ) : (
        <Box
          className={className}
          style={{
            padding: '16px 35px',
            display: 'flex',
            ...style
          }}
        >
          {children}
        </Box>
      )}
  </Media>
);

ModalBox.propTypes = {
  children: PropTypes.oneOfType([
    PropTypes.arrayOf(PropTypes.element),
    PropTypes.element
  ]).isRequired,
  style: PropTypes.object,
  className: PropTypes.string
};

export default ModalBox;
