import React from 'react';
import styled from 'styled-components';
//
import ContainerFlex from 'base_components/ContainerFlex';
import TitleSection from '../TitleSection';
import ButtonAdd from 'base_components/ButtonAdd';
import ListObjectives from './components/ListObjectives';
import FooterTotalWeights from './components/FooterTotalWeights';

const ContainerTitle = ContainerFlex.extend`
  padding-bottom: 0.5em;
  margin-bottom: 1.5em;
  border-bottom: 1px solid #d8d8d8;
`;

const TitleObjective = TitleSection.extend`
  margin: 1.3em 0 0;

  @media screen and (min-width: 768px) {
    margin-bottom: 0;
  }
`;

const ButtonAddObjective = styled(ButtonAdd)`
  margin-right: 0;
  color: #000000;
  background-color: transparent;
  border: 1px solid #000000;
  width: 85px;

  &:hover {
    background-color: #e2e2e2;
    color: #000000;
  }
`;

const SectionObjectiveCourse = () => (
  <section>
    <ContainerTitle isAlignCenter isSpaceBetween>
      <TitleObjective>Objectives / Outcomes</TitleObjective>
      <ButtonAddObjective text="Add" />
    </ContainerTitle>
    <ListObjectives />
    <FooterTotalWeights />
  </section>
);

export default SectionObjectiveCourse;
