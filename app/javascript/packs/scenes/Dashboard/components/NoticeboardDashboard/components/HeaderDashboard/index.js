import React from 'react';
// NoticeboardDashboard Header
import { MainHeaderTitle } from 'base_components/Main';
import Caret from 'react-icons/lib/fa/caret-down';

const Header = MainHeaderTitle.extend`
  display: flex;
  justify-content: space-between;

  p {
    margin-bottom: 0;
    color: #111111;
    font-size: 16px;
  }

  span {
    text-transform: uppercase;
    margin-right: 0.5em;
  }

  @media screen and (min-with: 768px) {
    border-right: 0px;
  }
`;

const HeaderDashboard = () => (
  <Header>
    <p>Noticeboard</p>
    <div>
      <span>Most Recent</span>
      <Caret />
    </div>
  </Header>
);

export default HeaderDashboard;
