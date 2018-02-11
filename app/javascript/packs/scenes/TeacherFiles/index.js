import React from 'react';
import styled from 'styled-components';

import iconUpload from './iconUpload.svg';
import {
  MainInnerContainer,
  MainHeaderTitle,
  MainLeft,
  MainRight
} from 'base_components/Main';
import TableFiles from 'base_components/TableFiles';
import SearchBar from 'base_components/RootSearchBar';
import Button from 'base_components/RootButton';

//----------- for button component ------------
const ButtonUpload = Button.extend`
  width: 100%;
  margin-bottom: 1.2em;
`;

const SpanButtonUpload = styled.span`
  margin-right: 0.8em;
  display: inline-block;
`;

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

const TeacherFiles = () => (
  <div>
    <MainHeaderTitle>
      <span>Files</span>
    </MainHeaderTitle>
    <MainInnerContainer>
      <MainLeft>
        <TableFiles files={files} />
      </MainLeft>
      <MainRight>
        <ButtonUpload secondary>
          <SpanButtonUpload>Upload File</SpanButtonUpload>
          <img alt="Upload icon" src={iconUpload} />
        </ButtonUpload>
        <SearchBar />
      </MainRight>
    </MainInnerContainer>
  </div>
);

export default TeacherFiles;
