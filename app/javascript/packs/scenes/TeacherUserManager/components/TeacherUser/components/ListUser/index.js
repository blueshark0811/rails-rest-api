import React from 'react';
import styled from 'styled-components';

import UserAvatar from 'base_components/UserAvatar';
import iconUser from 'resources/images/user.png';

// the list component
const List = styled.ul`
  margin-top: 1.5em;

  @media screen and (min-width: 768px) {
    margin-top: 2em;
  }
`;

// the list item user component.
const ListItemUser = styled(({ className }) => (
  <li className={className}>
    <UserAvatar image={iconUser} />
    <span>Jane Doe</span>
  </li>
))`
  display: flex;
  align-items: center;
  padding: 0.8em;
  background-color: ${props => props.active && 'rgba(184,184,184,.2)'};

  span {
    color: #111111;
    margin-left: 0.7em;
  }

  @media screen and (min-width: 768px) {
    padding: 0.8em 2.6em;
  }
`;

// hold the List of user components.
const ListUser = () => (
  <List>
    <ListItemUser active />
    <ListItemUser />
    <ListItemUser />
  </List>
);

export default ListUser;
