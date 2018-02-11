import React from 'react';

import ModalBox from '../../../../ModalBox';
import { $black, $border } from 'shared/color.js';

const TutorialDetails = () => (
  <ModalBox style={tutorialDetailsStyle.div} className="TutorialInfo__details">
    <h3 style={tutorialDetailsStyle.headline}>Tutorial 1</h3>
    <p>
      Text goes here that explains what this tutorial is about. It could inlude
      the speakers name and any instructions that go along with this lesson.
    </p>
    <p>
      Goes here that explains what this tutorial is about. It could inlude the
      speakers name and any instructions that go along with this lesson.
    </p>
  </ModalBox>
);

const tutorialDetailsStyle = {
  div: {
    borderBottom: $border,
    flexDirection: 'column'
  },
  headline: {
    color: $black,
    fontSize: '1.2rem',
    fontWeight: 800,
    margin: '15px 0px 15px'
  }
};

export default TutorialDetails;
