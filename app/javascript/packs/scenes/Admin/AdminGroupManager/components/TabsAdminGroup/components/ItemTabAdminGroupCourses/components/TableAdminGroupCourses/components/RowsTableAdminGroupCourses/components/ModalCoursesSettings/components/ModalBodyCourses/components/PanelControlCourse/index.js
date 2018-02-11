import React from 'react';
// base
import Panel from 'base_components/Panel';
// for list item control.
import ListControl, { ListItemControl } from 'base_components/ListControl';
import Button from 'base_components/RootButton';
import { Label } from 'base_components/RootForm';

const PanelControlCourse = () => (
  <Panel isFullWidth>
    <ListControl>
      <ListItemControl>
        <Button large light lightBorder>
          Pause course
        </Button>
        <Label light>
          Course remains visible to teachers but access is denied for students.
        </Label>
      </ListItemControl>
      <ListItemControl>
        <Button light large lightBorder>
          Remove course
        </Button>
        <Label light>
          Once this course has been removed it cannot be restored. All data will
          be lost.
        </Label>
      </ListItemControl>
    </ListControl>
  </Panel>
);

export default PanelControlCourse;
