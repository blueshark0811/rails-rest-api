import React from 'react';
import styled from 'styled-components';

import NoticeboardDashboard from './components/NoticeboardDashboard';
import ReportDashboard from './components/ReportDashboard';

const Dashboard = styled(({ className }) => (
  <div className={className}>
    <NoticeboardDashboard />
    <ReportDashboard />
  </div>
))`
  @media screen and (min-width: 768px) {
    display: flex;
  }
`;

export default Dashboard;
