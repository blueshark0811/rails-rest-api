import React from 'react';
import styled from 'styled-components';

import ListMessages from './components/ListMessages';
import iconPen from './write-pen.svg';

const MessagesList = styled(({ className }) => {
  return (
    <div className={className}>
      <header>
        <span>New Message</span>
        <img alt="Icon pen" src={iconPen} />
      </header>
      <ListMessages />
    </div>
  );
})`
  header {
    border-bottom: 1px solid #dadada;
    padding: 0.8em;
    display: flex;
    align-items: center;
    justify-content: flex-end;
    span {
      font-size: 0.8rem;
      text-transform: uppercase;
      color: #adadad;
      margin-right: 0.5em;
    }
    img {
      margin-bottom: 0.4em;
    }
  }
`;

export default MessagesList;
