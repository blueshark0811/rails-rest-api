import React from 'react';
import styled from 'styled-components';

import DateTime from 'base_components/DateTime';

// the list component
const List = styled.ul`
  margin-top: 0.9em;
  padding: 0 2%;

  @media screen and (min-width: 768px) {
    margin-top: 1.5em;
  }
`;

// the list item component.
const Item = styled(({ className }) => (
  <li className={className}>
    <DateTime date="22 Sep" time="1:00pm" />
    <p>You have recieved access to a new course - Communication and Culture.</p>
  </li>
))`
  display: flex;
  align-items: center;
  border-bottom: 1px solid #dbdbdb;
  padding: 1.3em 0;

  p {
    margin-bottom: 0;
    font-size: 16px;
    color: #2d2d2d;
    margin-left: 0.5em;
  }

  @media screen and (min-width: 768px) {
    width: 77%;
    margin: 0 auto;
    padding: 2em 0;

    p {
      margin-left: 2em;
    }
  }
`;

// handling the list of notification
const ListNotification = () => (
  <List>
    <Item />
    <Item />
  </List>
);

export default ListNotification;
