import React from 'react';
import styled from 'styled-components';
// Container
import { ContainerSearchbarList } from '../../../../../components/ContainerAdminPanel/components/ContainerFilterableList';
// Sub components
import Dropdown from 'base_components/Dropdown';
import { MenuItem } from 'react-bootstrap';
import Button from 'base_components/RootButton';
import Form, { Text } from 'base_components/RootForm';

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

  .caret {
    padding-bottom: 4px;
  }
`;

const SearchbarListAdminUser = styled(({ className }) => (
  <ContainerSearchbarList className={className}>
    <Button secondary>Show All</Button>
    <DropdownRefine title="Refine" id="dropdown-size-medium">
      <MenuItem eventKey="1">Action</MenuItem>
      <MenuItem eventKey="2">Another action</MenuItem>
      <MenuItem eventKey="3">Something else here</MenuItem>
      <MenuItem divider />
      <MenuItem eventKey="4">Separated link</MenuItem>
    </DropdownRefine>
    <Form>
      <Text name="create-user" placeholder="Search users" />
    </Form>
    <Button>Create a user</Button>
  </ContainerSearchbarList>
))`
  @media screen and (min-width: 768px) {
    button {
      margin-right: 0.6em;
      &:last-child {
        margin-right: 0;
      }
    }
    form {
      margin-right: 0.6em;
    }
  }
`;

export default SearchbarListAdminUser;
