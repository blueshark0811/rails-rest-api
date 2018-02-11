import React from 'react';
import { MenuItem } from 'react-bootstrap';
// component
import Dropdown from 'base_components/Dropdown';
import Button from 'base_components/RootButton';
import ContainerFlex from 'base_components/ContainerFlex';

// extending the dropdown button style.
const DropdownRefine = Dropdown.extend`
  padding: 11px 15px 12px;
  background-color: #d8d8d8;
  border: 0;
  text-transform: uppercase;
  font-family: 'karla';
  font-size: 12px;
  font-weight: 800;
  border-radius: 3px;
  width: 100%;

  .caret {
    padding-bottom: 4px;
  }

  @media screen and (min-width: 768px) {
    width: 150px;
  }
`;

const ContainerControlButtons = ContainerFlex.extend`
  flex-direction: column;

  @media screen and (max-width: 767px) {
    > button {
      width: 100%;
      margin-bottom: 10px;
    }

    > button:last-child {
      margin-bottom: 0;
    }
  }

  @media screen and (min-width: 768px) {
    flex-direction: row;
    justify-content: space-between;

    > button:first-child {
      margin-right: 1em;
    }
  }
`;

const ControlButtonsGroup = () => (
  <ContainerControlButtons>
    <Button secondary>Show All</Button>
    <DropdownRefine title="Refine" id="dropdown-size-medium">
      <MenuItem eventKey="1">Action</MenuItem>
      <MenuItem eventKey="2">Another action</MenuItem>
      <MenuItem eventKey="3">Something else here</MenuItem>
      <MenuItem divider />
      <MenuItem eventKey="4">Separated link</MenuItem>
    </DropdownRefine>
  </ContainerControlButtons>
);

export default ControlButtonsGroup;
