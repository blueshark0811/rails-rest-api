import React from 'react';
import styled from 'styled-components';
import ModalFooter from 'react-bootstrap/lib/ModalFooter';

import MessageForm from 'base_components/MessageForm';

const ThreadModalFooter = styled(({ className }) => (
  <ModalFooter className={className}>
    <div>
      <MessageForm />
    </div>
  </ModalFooter>
))`
  width: 100%;

  > div {
    max-width: 774px;
    margin: 0 auto;
  }
`;

export default ThreadModalFooter;
