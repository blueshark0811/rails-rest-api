import React from 'react';
import styled from 'styled-components';
// components
import Container from 'base_components/Container';
import SearchBar from 'base_components/RootSearchBar';
import ControlButtonsGroup from './components/ControlButtonsGroup';

const SearchbarCourses = styled(SearchBar)`
  margin-top: 10px;

  > div {
    margin-bottom: 0;
  }

  @media screen and (min-width: 768px) {
    margin-top: 0;
  }
`;

const ContainerHeaderTable = Container.extend`
  padding: 1.5em 2%;
  margin: 0;
  border-bottom: 1px solid #d8d8d8;
  display: flex;
  flex-direction: column;

  @media screen and (min-width: 768px) {
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
  }
`;

const HeaderTableCourses = () => (
  <ContainerHeaderTable>
    <ControlButtonsGroup />
    <SearchbarCourses placeholder="Search courses" />
  </ContainerHeaderTable>
);

export default HeaderTableCourses;
