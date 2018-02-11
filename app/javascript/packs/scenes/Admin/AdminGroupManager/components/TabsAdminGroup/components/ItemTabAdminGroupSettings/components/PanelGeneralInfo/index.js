import React from 'react';

import Panel from 'base_components/Panel';
import { FormGroup, Text, TextArea, Label } from 'base_components/RootForm';

// we will extending the panel base styles
const PanelExtend = Panel.extend`
  padding-top: 6px;
`;

const PanelGeneralInfo = () => (
  <PanelExtend title="General Information">
    <FormGroup>
      <Label htmlFor="group-name">Group Name</Label>
      <Text name="group-name" placeholder="Connect: Level 1" />
    </FormGroup>
    <FormGroup>
      <Label htmlFor="group-discussion">Group Discussion</Label>
      <TextArea name="group-name" placeholder="Connect: Level 1" row={4} />
    </FormGroup>
  </PanelExtend>
);

export default PanelGeneralInfo;
