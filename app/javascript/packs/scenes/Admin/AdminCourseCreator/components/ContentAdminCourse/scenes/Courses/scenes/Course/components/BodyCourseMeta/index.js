import React from 'react';
import styled from 'styled-components';
// for Tab Component
import { Tab } from 'react-bootstrap';
import Tabs from 'base_components/Tabs';
//
import Box from 'base_components/Box';
import ItemTutorialCourse from './components/ItemTutorialCourse';
import ItemReportingCourse from './components/ItemReportingCourse';

const BoxBodyCourse = styled(Box)`
  @media screen and (min-width: 768px) {
    padding-bottom: 85px;
  }
`;

const BodyCourseMeta = () => (
  <BoxBodyCourse>
    <Tabs>
      <Tab eventKey={1} title="Tutorials">
        <ItemTutorialCourse />
      </Tab>
      <Tab eventKey={2} title="Reporting/Assesing">
        <ItemReportingCourse />
      </Tab>
    </Tabs>
  </BoxBodyCourse>
);

export default BodyCourseMeta;
