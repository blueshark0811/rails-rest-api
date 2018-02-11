import React from 'react';
import styled from 'styled-components';

import RootForm, { TextArea } from 'base_components/RootForm';
import iconDropfile from 'resources/images/dropfile.svg';
import Button from 'base_components/RootButton';

const MessageForm = styled(({ className }) => (
  <RootForm className={className}>
    <TextArea name="thread" placeholder="Write Something" />
    <div>
      <img src={iconDropfile} alt="Drop file" />
      <Button>Submit</Button>
    </div>
  </RootForm>
))`
  div {
    text-align: right;
    margin-top: 0.5em;
    img {
      margin-right: 1em;
    }
  }
`;

export default MessageForm;
