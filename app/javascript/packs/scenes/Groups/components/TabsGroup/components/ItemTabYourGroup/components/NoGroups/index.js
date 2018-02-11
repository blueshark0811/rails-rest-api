import React from 'react';
import styled from 'styled-components';

import InformationText from 'base_components/InformationText';
import Button from 'base_components/RootButton';

// for view group button
const ViewGroupButton = Button.extend`
  display: block;
  margin: 0 auto 3em auto;
  width: 195px;
`;

const NoGroups = styled(({ className }) => (
  <div className={className}>
    <h1>You are not part of any groups yet.</h1>
    <p>
      You must belong to a group to have access to any available courses or
      discussion. View public groups on the groups page or contact an
      administrator about joining a private group.
    </p>
    <ViewGroupButton>View Public Groups</ViewGroupButton>
    <InformationText to="/learn-groups" text="Learn more about groups" />
  </div>
))`
  margin-top: 3.5em;
  text-align: center;

  h1 {
    font-size: 1.5rem;
    color: #505050;
    font-weight: 500;
    font-family: 'Avenir Next';
    margin-bottom: 1em;
  }

  p {
    font-size: 1.01rem;
    color: #9f9f9f;
    text-align: center;
  }

  @media screen and (min-width: 768px) {
    margin-top: 5em;
  }
`;

export default NoGroups;
