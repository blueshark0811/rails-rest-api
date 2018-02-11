import React from 'react';
import styled from 'styled-components';

// this is for the user list.
import Form, { Text } from 'base_components/RootForm';
import ListUser from './components/ListUser';

const TeacherUser = styled(({ className }) => (
  <div className={className}>
    <Form>
      <Text name="user-searchbar" placeholder="Search people..." />
    </Form>
    <ListUser />
  </div>
))`
  @media screen and (min-width: 768px) {
    width: 30%;
    border-right: 1px solid #dadada;

    form {
      padding: 0 20px;
      margin-top: 25px;
    }
  }
`;

export default TeacherUser;
