import React from 'react';
import Media from 'react-media';
import moment from 'moment';
/* import './styles.css';*/

// sub-components
import VideoForMobile from './components/VideoForMobile';
import VideoForDesktop from './components/VideoForDesktop';
import VideoMedia from './components/VideoMedia/index.js';
import VideoRunningTime from './components/VideoRunningTime';

class VideoPlayer extends React.Component {
  constructor() {
    super();
    this.state = {
      player: {},
      currentTime: ''
    };
  }

  handleStateChange = (state, prevState) => {
    // copy player state to this component's state
    this.setState({
      player: state,
      currentTime: state.currentTime
    });
  };

  render() {
    // transform the current time of the video in hourly format.
    const currentTime = moment()
      .startOf('day')
      .seconds(this.state.currentTime)
      .format('H:mm:ss');

    return (
      <Media query="(max-width: 767px)">
        {matches =>
          matches ? (
            <div className="VideoPlayer" style={videoPlayerStyle.container}>
              <VideoForMobile handleStateChange={this.handleStateChange} />
              <VideoMedia />
              <VideoRunningTime currentTime={currentTime} />
            </div>
          ) : (
            <div
              className="VideoPlayer"
              style={videoPlayerStyle.desktopViewport}
            >
              <VideoForDesktop handleStateChange={this.handleStateChange} />
              <VideoMedia />
              <VideoRunningTime currentTime={currentTime} />
            </div>
          )}
      </Media>
    );
  }
}

// styles
const videoPlayerStyle = {
  container: {
    width: '100%'
  },
  desktopViewport: {
    width: '100%',
    display: 'flex',
    justifyContent: 'space-between',
    background: '#000000'
  }
};

export default VideoPlayer;
