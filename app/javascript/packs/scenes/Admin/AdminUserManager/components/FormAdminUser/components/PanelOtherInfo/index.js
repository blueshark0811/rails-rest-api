import React from 'react';
import styled from 'styled-components';
import { MenuItem } from 'react-bootstrap';
// components
import { FormGroup, Label, Text, TextArea } from 'base_components/RootForm';
import FormGroupLeft from '../FormGroupLeft';
import PanelAdminUser from '../PanelAdminUser';
import ContainerFlex from 'base_components/ContainerFlex';
import Dropdown from 'base_components/Dropdown';

// form group downdown
const FormGroupDropdown = styled(FormGroup)`
  flex: 1;
  margin-right: 0.6em;

  .dropdown {
    width: 100%;

    button {
      width: 100%;
      height: 40px;
      display: flex;
      align-items: center;
      justify-content: space-between;
    }
  }
`;

// for zip code text
const FormGroupZipCode = styled(FormGroup)`
  width: 25%;
`;

const PanelOtherInfo = () => (
  <PanelAdminUser>
    <ContainerFlex>
      <FormGroupLeft>
        <Label>Phone Number</Label>
        <Text name="phoneNumber" placeholder="+61908434" />
      </FormGroupLeft>
      <FormGroup>
        <Label>Date of Birth</Label>
        <Text name="dateOfBirth" placeholder="December 05, 1995" />
      </FormGroup>
    </ContainerFlex>
    <FormGroup>
      <Label>Address</Label>
      <TextArea name="address" row={4} placeholder="Address" />
    </FormGroup>
    <ContainerFlex>
      <FormGroupDropdown>
        <Dropdown title="Country" id="dropdown-size-medium">
          <MenuItem eventKey="1">Action</MenuItem>
          <MenuItem eventKey="2">Another action</MenuItem>
          <MenuItem eventKey="3">Something else here</MenuItem>
          <MenuItem divider />
          <MenuItem eventKey="4">Separated link</MenuItem>
        </Dropdown>
      </FormGroupDropdown>
      <FormGroupDropdown>
        <Dropdown title="State" id="dropdown-size-medium">
          <MenuItem eventKey="1">Action</MenuItem>
          <MenuItem eventKey="2">Another action</MenuItem>
          <MenuItem eventKey="3">Something else here</MenuItem>
          <MenuItem divider />
          <MenuItem eventKey="4">Separated link</MenuItem>
        </Dropdown>
      </FormGroupDropdown>
      <FormGroupZipCode>
        <Text name="zipCode" placeholder="Zip code" />
      </FormGroupZipCode>
    </ContainerFlex>
  </PanelAdminUser>
);

export default PanelOtherInfo;
