import React from 'react';
import styled from 'styled-components';

import HeaderDashboard from './components/HeaderDashboard';
import BodyDashboard from './components/BodyDashboard';

const ContainerNoticeboard = styled.div`
  border-right: 1px solid #dadada;

  @media screen and (min-width: 768px) {
    width: 60%;
  }
`;

// noticeboard component.
const NoticeboardDashboard = () => (
  <ContainerNoticeboard>
    <HeaderDashboard />
    <BodyDashboard />
  </ContainerNoticeboard>
);

export default NoticeboardDashboard;
