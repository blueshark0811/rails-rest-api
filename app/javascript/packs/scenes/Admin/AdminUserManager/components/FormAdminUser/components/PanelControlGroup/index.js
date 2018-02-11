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
          Suspend user
        </Button>
        <Label light>
          Once student account is suspended you can activate again at any time.
        </Label>
      </ListItemControl>
      <ListItemControl>
        <Button light large lightBorder>
          Remove user
        </Button>
        <Label light>
          If this user is removed all data associated with the user is lost.
        </Label>
      </ListItemControl>
    </ListControl>
  </Panel>
);

export default PanelControlGroup;
