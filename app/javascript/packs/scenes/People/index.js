import React from 'react';

import { MainInnerContainer, MainLeft } from 'base_components/Main';
import TabsPeople from './components/TabsPeople';
import Sidebar from './components/Sidebar';

const People = () => (
  <MainInnerContainer>
    <MainLeft>
      <TabsPeople />
    </MainLeft>
    <Sidebar />
  </MainInnerContainer>
);

export default People;
