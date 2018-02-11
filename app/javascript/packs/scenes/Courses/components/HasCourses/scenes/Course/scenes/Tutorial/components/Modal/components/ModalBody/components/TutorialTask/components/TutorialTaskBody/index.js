import React from 'react';
import { Tab } from 'react-bootstrap';

// base components
import Tabs from 'base_components/Tabs';
import Box from 'base_components/Box';

// sub-components
import ItemTableTutorialFiles from './components/ItemTableFilesTutorial';
import ItemTutorialTaskGroups from './components/ItemTutorialTaskGroup';

const TutorialTaskBody = () => {
  const files = [
    {
      id: 'ysdjfk',
      file: 'Submissions instructions.pdf',
      date: '22 April 17'
    },
    {
      id: 'yskjdksf',
      file: 'Showing culture.ptt',
      date: '19 March 17'
    }
  ];

  return (
    <Box>
      <Tabs>
        <Tab eventKey={1} title="Questions & Activities">
          <ItemTutorialTaskGroups />
        </Tab>
        <Tab eventKey={2} title="Files">
          <ItemTableTutorialFiles files={files} />
        </Tab>
      </Tabs>
    </Box>
  );
};

TutorialTaskBody.propTypes = {};

export default TutorialTaskBody;
