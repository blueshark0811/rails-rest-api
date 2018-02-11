import React from 'react';
import styled from 'styled-components';

// list item
const ListItem = styled.li`
  color: #000000;
  margin: 1em 0;
`;

// list container
const List = styled.ul`
  width: 75%;
  background-color: #d8d8d8;
  border: 1px solid #e0e0e0;
  margin-right: 1em;
  padding: 0em 1em 1em;
`;

const ListGroups = () => (
  <List>
    <ListItem>Connect Level 1</ListItem>
    <ListItem>Connect Level 2</ListItem>
  </List>
);

export default ListGroups;
