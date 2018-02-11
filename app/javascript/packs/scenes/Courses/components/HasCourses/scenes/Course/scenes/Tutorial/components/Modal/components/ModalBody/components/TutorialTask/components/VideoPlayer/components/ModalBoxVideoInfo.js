import React from 'react';
import PropTypes from 'prop-types';
import Media from 'react-media';

import ModalBox from '../../../../../../ModalBox.js';

const ModalBoxVideoInfo = ({ style, children }) => (
  <Media query="(max-width: 767px)">
    {matches =>
      matches ? (
        <ModalBox
          style={{
            ...modalBoxVideoInfoStyle,
            ...style
          }}
        >
          {children}
        </ModalBox>
      ) : (
        <ModalBox
          style={{
            ...style,
            ...modalBoxVideoInfoStyle.desktopViewport
          }}
        >
          {children}
        </ModalBox>
      )}
  </Media>
);

// styles
const modalBoxVideoInfoStyle = {
  width: '50%',
  float: 'left',
  marginTop: '0.5em',
  desktopViewport: {
    width: '25%'
  }
};

ModalBoxVideoInfo.propTypes = {
  children: PropTypes.oneOfType([
    PropTypes.arrayOf(PropTypes.element),
    PropTypes.element
  ]),
  style: PropTypes.object
};

export default ModalBoxVideoInfo;
