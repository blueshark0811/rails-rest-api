import React from 'react';
import styled from 'styled-components';

import Panel from 'base_components/Panel';
import { FormGroup, Label, Switch } from 'base_components/RootForm';

const PanelExtend = Panel.extend`
  padding-bottom: 0;

  header label {
    margin-right: 0.9em;
  }

  @media screen and (min-width: 768px) {
    header {
      width: 315px;

      label {
        margin-right: 0;
      }
    }
  }
`;

const LabelNoticeBoard = Label.extend`
  width: 134px;
  margin-right: 8em;
`;

const ContainerFormGroups = styled.div`
  padding: 14px;
  background: #fbfbfb;

  @media screen and (min-width: 768px) {
    padding: 27px;
  }
`;

const PanelGroupNoticeBoard = () => (
  <PanelExtend
    title="Group Noticeboard"
    AdditionalTitle={() => <Switch name="toggle-all" />}
  >
    <ContainerFormGroups>
      <FormGroup isFlex>
        <LabelNoticeBoard>Students can post new content</LabelNoticeBoard>
        <Switch name="post-content" />
      </FormGroup>
      <FormGroup isFlex>
        <LabelNoticeBoard>Students can comment</LabelNoticeBoard>
        <Switch name="post-comment" />
      </FormGroup>
    </ContainerFormGroups>
  </PanelExtend>
);

export default PanelGroupNoticeBoard;
