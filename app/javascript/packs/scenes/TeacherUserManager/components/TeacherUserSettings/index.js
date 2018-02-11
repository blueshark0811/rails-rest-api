import React from 'react';
import styled from 'styled-components';

// base components
import { MainInnerContainer } from 'base_components/Main';
import { Tab } from 'react-bootstrap';
import Tabs from 'base_components/Tabs';
// child components.
import ItemTeacherUserCourses from './components/ItemTeacherUserCourses';

// for teacher user settings.
const ItemTeacherUserSettings = () => <div>user settings</div>;

const TeacherUserSettings = styled(({ className }) => (
  <MainInnerContainer className={className}>
    <Tabs style={{ marginTop: 0, width: '100%' }}>
      <Tab eventKey={1} title="Courses">
        <ItemTeacherUserCourses />
      </Tab>
      <Tab eventKey={2} title="Settings">
        <ItemTeacherUserSettings />
      </Tab>
    </Tabs>
  </MainInnerContainer>
))`
  @media screen and (min-width: 768px) {
    width: 70%;
    padding: 16px 0;

    .nav-tabs {
      padding: 0 2.4em;
    }
  }
`;

export default TeacherUserSettings;
