import React from 'react';
import styled from 'styled-components';

import MessageForm from 'base_components/MessageForm';
import MessagesConvoList from './components/MessagesConvoList';

const MessagesConvo = styled(({ className }) => (
  <div className={className}>
    <header>
      <span>Conversation: Steve Long, Jane Doe</span>
    </header>
    <MessagesConvoList />
    <MessageForm />
  </div>
))`
  header {
    border-bottom: 1px solid #dadada;
    padding: 0.8em;
    display: flex;
    align-items: center;
    justify-content: flex-end;
    span {
      font-size: 0.8rem;
      color: #adadad;
      margin-top: 0.3em;
    }
  }

  form {
    padding: 1.6em 1.3em;
    width: 100%;
    background: #ffffff;
    border-top: 1px solid #dadada;
  }

  @media screen and (min-width: 768px) {
    border-left: 1px solid #dadada;
    min-height: 90vh;
    position: relative;

    form {
      position: absolute;
      bottom: 0;
    }
  }
`;

export default MessagesConvo;
