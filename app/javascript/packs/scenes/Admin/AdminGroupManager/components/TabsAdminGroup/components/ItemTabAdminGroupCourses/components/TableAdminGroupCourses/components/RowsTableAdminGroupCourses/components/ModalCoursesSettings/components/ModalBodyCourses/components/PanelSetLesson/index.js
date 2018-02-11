import React from 'react';
import styled from 'styled-components';
// base
import { Label, Checkbox, FormGroup } from 'base_components/RootForm';
import Panel from 'base_components/Panel';
import ContainerFlex from 'base_components/ContainerFlex';

const FormGroups = styled.div`
  margin-left: 2.2em;
  display: flex;
`;

const FormGroupSetLesson = FormGroup.extend`
  display: flex;
  margin-bottom: 0;
  margin-right: 1.5em;

  &:last-child {
    margin-right: 0;
  }

  > div {
    margin-right: 0.5em;
  }
`;

const PanelSetLesson = styled(({ className }) => (
  <Panel isFullWidth className={className}>
    <ContainerFlex>
      <span>Who is able to set lessons as complete?</span>
      <FormGroups>
        <FormGroupSetLesson>
          <Checkbox name="lesson-student" />
          <Label>Student</Label>
        </FormGroupSetLesson>
        <FormGroupSetLesson>
          <Checkbox name="lesson-teacher" />
          <Label>Teacher</Label>
        </FormGroupSetLesson>
      </FormGroups>
    </ContainerFlex>
  </Panel>
))`
  span {
    width: 145px;
  }
`;

export default PanelSetLesson;
