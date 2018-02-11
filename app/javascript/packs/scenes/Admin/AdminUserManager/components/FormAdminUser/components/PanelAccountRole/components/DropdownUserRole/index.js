import React from 'react';
import { MenuItem } from 'react-bootstrap';
// components.
import ContainerFlex from 'base_components/ContainerFlex';
import { Label } from 'base_components/RootForm';
import Dropdown from 'base_components/Dropdown';

const ContainerDropdown = ContainerFlex.extend`
  display: flex;
  align-items: center;
  margin-bottom: 2rem;

  label {
    margin-right: 1.8em;
  }

  .dropdown {
    width: 115px;
  }
`;

const DropdownUserRole = () => (
  <ContainerDropdown>
    <Label>Select user role</Label>
    <Dropdown title="Teacher" id="dropdown-size-medium">
      <MenuItem eventKey="1">Action</MenuItem>
      <MenuItem eventKey="2">Another action</MenuItem>
      <MenuItem eventKey="3">Something else here</MenuItem>
      <MenuItem divider />
      <MenuItem eventKey="4">Separated link</MenuItem>
    </Dropdown>
  </ContainerDropdown>
);

export default DropdownUserRole;
