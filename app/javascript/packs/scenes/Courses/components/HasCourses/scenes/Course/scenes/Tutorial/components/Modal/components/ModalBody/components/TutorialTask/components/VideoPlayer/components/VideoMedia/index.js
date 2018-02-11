import React from 'react';
import Media from 'react-media';

import ModalBoxVideoInfo from '../ModalBoxVideoInfo';
import DropdownMediaFile from './components/DropdownMediaFile/index.js';

const VideoMedia = () => (
  <Media query="(max-width: 767px)">
    {matches =>
      matches ? (
        <ModalBoxVideoInfo>
          <DropdownMediaFile />
        </ModalBoxVideoInfo>
      ) : (
        <ModalBoxVideoInfo style={{ order: 1 }}>
          <DropdownMediaFile />
        </ModalBoxVideoInfo>
      )}
  </Media>
);

export default VideoMedia;
