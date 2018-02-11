import React from 'react';
import styled from 'styled-components';

// the loading notification component
const LoadingNotification = styled(({ className }) => (
  <div className={className}>
    <div />
    <span>Loading</span>
  </div>
))`
  margin-top: 2.5em;
  text-align: center;

  > div {
    display: inline-block;
    height: 57px;
    width: 57px;
    border: 4px solid #1b93ec;
    border-radius: 50%;
  }

  span {
    display: block;
    font-size: 11px;
    color: #2d2d2d;
    margin-top: 0.5em;
  }

  @media screen and (min-width: 768px) {
    margin-top: 3.5em;
  }
`;

export default LoadingNotification;
