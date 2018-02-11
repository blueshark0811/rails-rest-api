import React from 'react';
import styled from 'styled-components';

import UserAvatar from 'base_components/UserAvatar';
import avatar from 'resources/images/user.png';
import Button from 'base_components/RootButton';

// People item template
const PeopleItem = styled(({ className }) => (
  <li className={className}>
    <div>
      <UserAvatar image={avatar} />
      <p>Jane Doe</p>
      <Button large>Send Message</Button>
    </div>
  </li>
))`
  margin-bottom: 1.5em;

  > div {
    display: inline-block;
    padding: 1.7em;
    border: 1px solid #e2e2e2;
    border-radius: 5px;

    p {
      text-align: center;
      margin-top: 0.7em;
      font-size: 14px;
      color: #111111;
    }
  }

  @media screen and (min-width: 768px) {
    margin-right: 1.5em;
  }
`;

// this is for people list template.
const PeopleList = styled.ul`
  margin-bottom: 2em;
  display: flex;
  flex-direction: column;
  text-align: center;

  @media screen and (min-width: 768px) {
    flex-direction: row;
    flex-wrap: wrap;
  }
`;

export { PeopleList as default, PeopleItem };
