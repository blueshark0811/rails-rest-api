import React from 'react';
import styled from 'styled-components';

import { MainRight } from 'base_components/Main';
import SearchBar from 'base_components/RootSearchBar';

const Sidebar = styled(({ className }) => (
  <MainRight className={className}>
    <SearchBar />
    <p>
      People can turn off their communication function. If you want to
      enable/disable messages go to settings.
    </p>
  </MainRight>
))`
  p {
    font-size: 13px;
    color: #515151;
    line-height: 1.5;
  }
`;

export default Sidebar;
