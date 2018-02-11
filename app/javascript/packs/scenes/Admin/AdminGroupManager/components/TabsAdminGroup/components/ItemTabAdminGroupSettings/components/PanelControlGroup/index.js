import React from 'react';

import Panel from 'base_components/Panel';
import ListControl, { ListItemControl } from 'base_components/ListControl';

// for list item control.
import Button from 'base_components/RootButton';
import { Label } from 'base_components/RootForm';

const PanelControlGroup = () => (
  <Panel>
    <ListControl>
      <ListItemControl>
        <Button large light lightBorder>
          Pause Group
        </Button>
        <Label light>
          Group remains visible to teachers but access is denied for students.
        </Label>
      </ListItemControl>
      <ListItemControl>
        <Button light large lightBorder>
          Remove Group
        </Button>
        <Label light>
          Once this group has been removed it cannot be restored. All data will
          be lost.
        </Label>
      </ListItemControl>
    </ListControl>
  </Panel>
);

export default PanelControlGroup;
