import React from 'react';
import PropTypes from 'prop-types';

import Media from 'react-media';
import ModalBoxVideoInfo from './ModalBoxVideoInfo';

const VideoRunningTime = ({ currentTime }) => {
  const { infoRunningTime, infoCurrentTime, boxInfo } = videoRunningTimeStyle;

  return (
    <Media query="(max-width: 767px)">
      {matches =>
        matches ? (
          <ModalBoxVideoInfo>
            <div>
              <span style={infoRunningTime}>Running Time</span>
              <p style={infoCurrentTime}>{currentTime}</p>
            </div>
          </ModalBoxVideoInfo>
        ) : (
          <ModalBoxVideoInfo style={boxInfo.desktopViewport}>
            <div style={{ textAlign: 'right' }}>
              <span
                style={{
                  ...infoRunningTime,
                  ...infoRunningTime.desktopViewport
                }}
              >
                Running Time
              </span>
              <p
                style={{
                  ...infoCurrentTime,
                  ...infoCurrentTime.desktopViewport
                }}
              >
                {currentTime}
              </p>
            </div>
          </ModalBoxVideoInfo>
        )}
    </Media>
  );
};

const videoRunningTimeStyle = {
  infoRunningTime: {
    fontSize: 10,
    color: '#4e4e4e',
    desktopViewport: {
      color: '#ffffff'
    }
  },
  infoCurrentTime: {
    fontSize: 14,
    marginBottom: 0,
    desktopViewport: {
      color: '#ffffff',
      textAlign: 'right',
      paddingRight: '1em'
    }
  },
  boxInfo: {
    desktopViewport: {
      order: 3,
      flexDirection: 'column',
      justifyContent: 'flex-end',
      marginBottom: '1.1em'
    }
  }
};

VideoRunningTime.propTypes = {
  currentTime: PropTypes.string.isRequired
};

export default VideoRunningTime;
