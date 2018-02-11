import React from 'react';
import styled from 'styled-components';
// assets
import iconBigSettings from 'resources/images/iconBigSettings.svg';

const ModalHeaderCourses = styled(({ className }) => (
  <header className={className}>
    <img alt="icon big settings" src={iconBigSettings} />
    <h4>Group Settings for: Communication and Culture</h4>
  </header>
))`
  padding: 25px 35px;
  border-bottom: 1px solid #dadada;
  display: flex;
  align-items: center;

  h4 {
    font-size: 1.1rem;
    color: #000000;
    font-weight: 800;
    line-height: 1.4;
    margin: 0 0 0 20px;
    width: 242px;
  }
`;

export default ModalHeaderCourses;
