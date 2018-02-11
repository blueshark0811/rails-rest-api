import React from 'react';
import { Player } from 'video-react';

import videoSrc from '../sample.mp4';
import posterSrc from '../poster.png';

class VideoForMobile extends React.Component {
  componentDidMount() {
    // subscribe state change
    this.refs.player.subscribeToStateChange(this.props.handleStateChange);
  }

  render() {
    return (
      <div>
        <Player ref="player" poster={posterSrc} playsInline>
          <source src={videoSrc} />
        </Player>
      </div>
    );
  }
}

export default VideoForMobile;
