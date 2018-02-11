import React from 'react';
import styled from 'styled-components';

import MessagesList from './components/MessagesList';
import MessagesConvo from './components/MessagesConvo';

const Messages = styled(({ className }) => {
  return (
    <div className={className}>
      <MessagesList />
      <MessagesConvo />
    </div>
  );
})`
  @media screen and (min-width: 768px) {
    display: flex;
  }
`;

export default Messages;
