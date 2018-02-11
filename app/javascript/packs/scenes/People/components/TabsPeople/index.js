import React from 'react';

// for Tab Component
import { Tab } from 'react-bootstrap';
import Tabs from 'base_components/Tabs';
// other components.
import ItemTabAllPeople from './components/ItemTabAllPeople';
import ItemTabStudentsPeople from './components/ItemTabStudentsPeople';
import ItemTabTeachersPeople from './components/ItemTabTeachersPeople';

const TabsPeople = () => (
  <Tabs>
    <Tab eventKey={1} title="All">
      <ItemTabAllPeople />
    </Tab>
    <Tab eventKey={2} title="Students">
      <ItemTabStudentsPeople />
    </Tab>
    <Tab eventKey={3} title="Teachers/Facilitator">
      <ItemTabTeachersPeople />
    </Tab>
  </Tabs>
);

export default TabsPeople;
