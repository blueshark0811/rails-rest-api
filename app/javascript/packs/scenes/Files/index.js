import React from 'react';

import {
  MainInnerContainer,
  MainHeaderTitle,
  MainLeft,
  MainRight
} from 'base_components/Main';
import TableFiles from 'base_components/TableFiles';
import SearchBar from 'base_components/RootSearchBar';

// test data
const files = [
  {
    id: 'ysdjfk',
    file: 'Submissions instructions.pdf',
    date: '22 April 17'
  },
  {
    id: 'yskjdksf',
    file: 'Showing culture.ptt',
    date: '19 March 17'
  }
];

const Files = () => (
  <div>
    <MainHeaderTitle>
      <span>Files</span>
    </MainHeaderTitle>
    <MainInnerContainer>
      <MainLeft>
        <TableFiles files={files} />
      </MainLeft>
      <MainRight>
        <SearchBar />
      </MainRight>
    </MainInnerContainer>
  </div>
);

export default Files;
