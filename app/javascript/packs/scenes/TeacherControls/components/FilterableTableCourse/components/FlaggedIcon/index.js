import React from 'react';
import styled from 'styled-components';
import IconFlag from 'react-icons/lib/fa/flag';

export default styled(({ className }) => (
  <span>
    <IconFlag className={className} />
  </span>
))`
  font-size: ${props => (props.big ? '1.4rem' : '1rem')};
  color: ${props => (props.isFlagged ? '#F44336' : '#D7D7D7')};
`;
