import React from 'react';
import styled from 'styled-components';

import TeacherUser from './components/TeacherUser';
import TeacherUserSettings from './components/TeacherUserSettings';

// this is for the teacher user manager container.
const ContainerTeacherUserManager = styled.div`
  padding: 2%;
  margin-top: 3%;

  @media screen and (min-width: 768px) {
    margin-top: 0;
    padding: 0;
    display: flex;
    min-height: 90vh;
  }
`;

const TeacherUserManager = () => (
  <ContainerTeacherUserManager>
    <TeacherUser />
    <TeacherUserSettings />
  </ContainerTeacherUserManager>
);

export default TeacherUserManager;
