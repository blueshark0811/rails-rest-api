import React from 'react';
import styled from 'styled-components';

const BoxCompleted = styled(({ className }) => (
  <div className={className}>
    <span>Tutorials</span>
  </div>
))`
  width: 104px;
  height: 104px;
  border: 4px solid #1b93ec;
  border-radius: 50%;
  position: relative;

  span {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    color: #979797;
    text-transform: capitalize;
  }

  @media screen and (min-width: 768px) {
    margin: 0 1em;
  }
`;

export default BoxCompleted;
