import React from 'react';

import TutorialTaskPanel from './TutorialTaskPanel';
import QuestionPanelContent from './QuestionPanelContent';

const TutorialQuizGroup = () => {
  return (
    <div>
      <TutorialTaskPanel
        category="Quiz"
        title="Do you agree with the statement that “absolutes are no longer popular” in our society? Give some examples from your own experience."
      >
        <QuestionPanelContent />
      </TutorialTaskPanel>
    </div>
  );
};

TutorialQuizGroup.propTypes = {};

export default TutorialQuizGroup;
