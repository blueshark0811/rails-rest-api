import React from 'react';

import TutorialQuestionsGroup from './components/TutorialQuestionsGroup';
import TutorialQuizGroup from './components/TutorialQuizGroup';
import TutorialReadingGroup from './components/TutorialReadingGroup';

const ItemTutorialTaskGroup = () => {
  return (
    <ul>
      <TutorialQuestionsGroup />
      <TutorialReadingGroup />
      <TutorialQuizGroup />
    </ul>
  );
};

export default ItemTutorialTaskGroup;
