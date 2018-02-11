import React from 'react';
import styled from 'styled-components';
//
import ContainerHeaderItemTab from '../../../ContainerHeaderItemTab';
import { Switch } from 'base_components/RootForm';

const HeaderReportingCourse = styled(({ className }) => (
  <ContainerHeaderItemTab className={className}>
    <span>Reporting System</span>
    <Switch name="reportingSystem" />
  </ContainerHeaderItemTab>
))`
  display: flex;
  align-items: center;

  > span {
    margin-right: 1em;
  }

  @media screen and (min-width: 768px) {
    margin-right: 2em;
  }
`;

export default HeaderReportingCourse;
