import React from 'react';
import PropTypes from 'prop-types';

import { Player } from 'video-react';
import videoSrc from '../sample.mp4';
import posterSrc from '../poster.png';

class VideoForDesktop extends React.Component {
  componentDidMount() {
    // subscribe state change
    this.refs.player.subscribeToStateChange(this.props.handleStateChange);
  }

  render() {
    return (
      <div style={videoForDesktopStyle}>
        <Player
          ref="player"
          poster={posterSrc}
          playsInline
          fluid={false}
          width={520}
          height={292}
        >
          <source src={videoSrc} />
        </Player>
      </div>
    );
  }
}

const videoForDesktopStyle = {
  order: 2
};

VideoForDesktop.propTypes = {
  handleStateChange: PropTypes.func.isRequired
};

export default VideoForDesktop;
