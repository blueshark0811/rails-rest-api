import React from 'react';
import styled from 'styled-components';
import { ButtonToolbar, MenuItem } from 'react-bootstrap';
// base components and some assets
import Panel from 'base_components/Panel';
import { Label, FormGroup } from 'base_components/RootForm';
import Dropdown from 'base_components/Dropdown';

// extending the form group
const FormGroupUser = FormGroup.extend`
  display: flex;
  align-items: center;
`;

const PanelUsers = styled(({ className }) => (
  <Panel className={className} title="Users">
    <FormGroupUser>
      <Label>Group Size Limit</Label>
      <ButtonToolbar>
        <Dropdown title="2" id="dropdown-size-medium">
          <MenuItem eventKey="1">Action</MenuItem>
          <MenuItem eventKey="2">Another action</MenuItem>
          <MenuItem eventKey="3">Something else here</MenuItem>
          <MenuItem divider />
          <MenuItem eventKey="4">Separated link</MenuItem>
        </Dropdown>
      </ButtonToolbar>
    </FormGroupUser>
    <FormGroupUser>
      <Label>Is group Public or Private?</Label>
      <ButtonToolbar>
        <Dropdown title="Private" id="dropdown-size-medium">
          <MenuItem eventKey="1">Action</MenuItem>
          <MenuItem eventKey="2">Another action</MenuItem>
          <MenuItem eventKey="3">Something else here</MenuItem>
          <MenuItem divider />
          <MenuItem eventKey="4">Separated link</MenuItem>
        </Dropdown>
      </ButtonToolbar>
    </FormGroupUser>
  </Panel>
))`
  label {
    width: 100px;
    margin-right: 2em;
    padding-top: 0.2em;

    &:first-child {
      margin-right: 1.7em;
    }
  }
`;

export default PanelUsers;
