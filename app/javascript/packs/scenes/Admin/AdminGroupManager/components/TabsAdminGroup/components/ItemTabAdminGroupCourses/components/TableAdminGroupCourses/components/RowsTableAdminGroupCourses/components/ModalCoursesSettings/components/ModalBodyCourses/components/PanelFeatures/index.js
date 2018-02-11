import React from 'react';
import styled from 'styled-components';
// base
import Panel from 'base_components/Panel';
import { Label, Switch } from 'base_components/RootForm';
import ContainerFlexCourses from '../ContainerFlexCourses';

const PanelFeatures = styled(({ className }) => (
  <Panel title="Features" isFullWidth className={className}>
    <ContainerFlexCourses isSpaceBetween>
      <Label>Reporting system</Label>
      <Switch name="reporting-system" />
    </ContainerFlexCourses>
    <ContainerFlexCourses isSpaceBetween>
      <Label>Course Files Page</Label>
      <Switch name="course-file" />
    </ContainerFlexCourses>
    <ContainerFlexCourses isSpaceBetween>
      <Label>Course Discussion Page</Label>
      <Switch name="course-discussion" />
    </ContainerFlexCourses>
    <ContainerFlexCourses isSpaceBetween>
      <Label>Students can post new content</Label>
      <Switch name="student-post" />
    </ContainerFlexCourses>
  </Panel>
))`
  padding-bottom: 0;

  > div:last-child {
    background-color: #fbfbfb;
    padding: 1.5em;
    margin-bottom: 0;

    > label:first-child {
      width: 130px;
    }
  }
`;

export default PanelFeatures;
