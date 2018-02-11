import React from 'react';

import TutorialTaskPanel from './TutorialTaskPanel';
import QuestionPanelContent from './QuestionPanelContent';

const TutorialReadingGroup = () => {
  return (
    <div>
      <TutorialTaskPanel
        category="Reading"
        title="Read the PDF document 'BEC' pages 22-25"
        isReadingGroup={true}
      >
        <QuestionPanelContent />
      </TutorialTaskPanel>
    </div>
  );
};

TutorialReadingGroup.propTypes = {};

export default TutorialReadingGroup;
