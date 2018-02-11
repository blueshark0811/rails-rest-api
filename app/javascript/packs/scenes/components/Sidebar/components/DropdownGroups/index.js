import React from 'react';
import { ButtonToolbar, DropdownButton, MenuItem } from 'react-bootstrap';

import './styles.css';

const DropdownGroups = () => {
  return (
    <ButtonToolbar className="DropdownGroups">
      <DropdownButton
        className="DropdownGroups__button"
        title="Group Select"
        id="dropdown-size-medium"
      >
        <MenuItem eventKey="1">Connect: Level 1</MenuItem>
        <MenuItem eventKey="2">Connect: Level 2</MenuItem>
        <MenuItem eventKey="3">Connect: Level 3</MenuItem>
        <MenuItem divider />
        <MenuItem eventKey="4">Separated link</MenuItem>
      </DropdownButton>
    </ButtonToolbar>
  );
};

export default DropdownGroups;
