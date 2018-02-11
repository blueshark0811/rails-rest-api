import React from 'react';
import { ButtonToolbar, MenuItem, DropdownButton } from 'react-bootstrap';

/* import './styles.css';*/

const DropdownMediaFile = () => (
  <div className="DropdownMediaFile">
    <ButtonToolbar>
      <DropdownButton title="Video" id="dropdown-size-medium">
        <MenuItem eventKey="1">Action</MenuItem>
        <MenuItem eventKey="2">Another action</MenuItem>
        <MenuItem eventKey="3">Something else here</MenuItem>
        <MenuItem divider />
        <MenuItem eventKey="4">Separated link</MenuItem>
      </DropdownButton>
    </ButtonToolbar>
  </div>
);

export default DropdownMediaFile;
