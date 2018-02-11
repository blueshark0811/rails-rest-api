import React from 'react';
import styled from 'styled-components';

import UserAvatar from 'base_components/UserAvatar';
import iconUser from 'resources/images/user.png';
import Form, { Text } from 'base_components/RootForm';
import DateTime from 'base_components/DateTime';

const ItemNotice = styled(({ className }) => (
  <li className={className}>
    <div>
      <UserAvatar image={iconUser} />
      <span>Jon Mccall</span>
      <DateTime date="22 Sep" time="2:00pm" />
    </div>
    <div>
      <p>
        Hi everyone. Dont forget to send in your registration forms for this
        weeks event. Anyone that can make it is welcome.
      </p>
      <Form>
        <Text name="comment" placeholder="Comment..." />
      </Form>
    </div>
  </li>
))`
  display: flex;
  border-bottom: 1px solid #dadada;
  padding: 2em 0 1.5em 0;

  > div:first-child {
    display: flex;
    flex-direction: column;
    margin-right: 0.8em;

    span:first-child {
      font-size: 10px;
      color: #1e1e1e;
    }
  }

  p {
    color: #000000;
  }
`;

// ListNotice component.
const ListNotice = () => (
  <ul>
    <ItemNotice />
    <ItemNotice />
  </ul>
);

export default ListNotice;
