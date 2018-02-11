import React from 'react';
import Media from 'react-media';

import TutorialDetails from './components/TutorialDetails';
import TutorialThingsToDo from './components/TutorialThingsToDo';

const TutorialInfo = () => {
  return (
    <Media query="(max-width: 767px)">
      {matches =>
        matches ? (
          <div className="TutorialInfo" style={tutorialInfoContainer}>
            <TutorialDetails />
            <TutorialThingsToDo />
          </div>
        ) : (
          <div
            className="TutorialInfo"
            style={tutorialInfoContainer.desktopViewport}
          >
            <TutorialDetails />
            <TutorialThingsToDo />
          </div>
        )}
    </Media>
  );
};

const tutorialInfoContainer = {
  backgroundColor: '#F0F0F0',
  desktopViewport: {
    backgroundColor: '#F0F0F0',
    width: '30%'
  }
};

export default TutorialInfo;
