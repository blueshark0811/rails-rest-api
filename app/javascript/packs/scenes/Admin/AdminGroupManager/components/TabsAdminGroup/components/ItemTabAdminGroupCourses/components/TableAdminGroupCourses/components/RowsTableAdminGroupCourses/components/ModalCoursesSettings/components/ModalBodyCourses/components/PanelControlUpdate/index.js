import React from 'react';
// base
import Panel from 'base_components/Panel';
import Button from 'base_components/RootButton';

/* extending the panel styles*/
const PanelUpdate = Panel.extend`
  border-bottom: 0;
  padding-bottom: 0;
`;

const PanelControlUpdate = () => (
  <PanelUpdate isFullWidth>
    <Button>Update</Button>
  </PanelUpdate>
);

export default PanelControlUpdate;
