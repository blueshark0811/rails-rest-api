import React from 'react';
import styled from 'styled-components';
import { MenuItem } from 'react-bootstrap';
// components
import ContainerFlex from 'base_components/ContainerFlex';
import Dropdown from 'base_components/Dropdown';
import { Label, Switch } from 'base_components/RootForm';

const AccountContainer = styled(({ className }) => (
  <div className={className}>
    <ContainerFlex isSpaceBetween>
      <Label>Exclude students from teacher</Label>
      <Dropdown title="Select Students" id="dropdown-size-medium">
        <MenuItem eventKey="1">Action</MenuItem>
        <MenuItem eventKey="2">Another action</MenuItem>
        <MenuItem eventKey="3">Something else here</MenuItem>
        <MenuItem divider />
        <MenuItem eventKey="4">Separated link</MenuItem>
      </Dropdown>
    </ContainerFlex>
    <ContainerFlex isSpaceBetween>
      <Label>File Control Priveleges</Label>
      <Switch name="fileControlPriveleges" />
    </ContainerFlex>
  </div>
))`
  background: #F3F3F3;
  padding: 1.8em;
  margin-bottom: 2em;

  > div{
    margin-bottom: 1.2em;

    > label{
        width: 85px;

        & ~ .dropdown{
          flex: 1;
          margin-left: 2em;
          height: 34px;
        }

        &:last-child{
          width: 42px;
        }
    

    &:last-child{
      margin-bottom: 0;
    }
  }
`;

export default AccountContainer;
