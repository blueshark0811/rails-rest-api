import React from 'react';
import styled from 'styled-components';

import ListItemTutorial from './components/ListItemTutorial';

// this is for list
const List = styled.ul`
  overflow-x: auto;
`;

// This is the main component.
const ListTutorialCourse = () => (
  <List>
    <ListItemTutorial />
    <ListItemTutorial />
    <ListItemTutorial isReport />
  </List>
);

export default ListTutorialCourse;
