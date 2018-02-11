import React from 'react';
import Media from 'react-media';

import VideoPlayer from './components/VideoPlayer';
import TutorialTaskBody from './components/TutorialTaskBody';

const TutorialTask = () => {
  return (
    <Media query="(max-width: 767px)">
      {matches =>
        matches ? (
          <div className="TutorialTask">
            <VideoPlayer />
            <TutorialTaskBody />
          </div>
        ) : (
          <div
            style={{
              ...tutorialTaskStyle
            }}
            className="TutorialTask"
          >
            <VideoPlayer />
            <TutorialTaskBody />
          </div>
        )}
    </Media>
  );
};

// component style
const tutorialTaskStyle = {
  width: '70%'
};

export default TutorialTask;
