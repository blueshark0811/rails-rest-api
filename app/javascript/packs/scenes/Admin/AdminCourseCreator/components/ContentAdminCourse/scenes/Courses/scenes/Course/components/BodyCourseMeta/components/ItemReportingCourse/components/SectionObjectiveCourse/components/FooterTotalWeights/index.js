import React from 'react';
import styled from 'styled-components';

// for label component
const LabelTotal = styled.label`
  display: block;
  text-align: center;
  background-color: #e9e9e9;
  font-size: 1.5rem;
  color: ${props => props.red && '#E40012'};
`;

const FooterTotalWeights = styled(({ className }) => (
  <footer className={className}>
    <div>
      <span>Total mark with weights</span>
      <LabelTotal red>120</LabelTotal>
      <LabelTotal>100</LabelTotal>
    </div>
  </footer>
))`
  padding: 1.2em;
  display: flex;
  justify-content: flex-end;
  border-bottom: 1px solid #d8d8d8;
  margin-bottom: 1.8em;

  span {
    display: block;
    font-size: 0.8rem;
    margin-bottom: 0.6em;
  }
`;

export default FooterTotalWeights;
