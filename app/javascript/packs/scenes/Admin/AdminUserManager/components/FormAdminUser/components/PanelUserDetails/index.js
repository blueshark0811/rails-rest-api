import React from 'react';
// base components
import PanelAdminUser from '../PanelAdminUser';
import FormGroupLeft from '../FormGroupLeft';
import ContainerFlex from 'base_components/ContainerFlex';
import UserAvatar from 'base_components/UserAvatar';
import iconUser from 'resources/images/user.png';
// Forms
import { FormGroup, Label, Text } from 'base_components/RootForm';
import Button from 'base_components/RootButton';

// adding styles for user avatar
const FormUserAvatar = UserAvatar.extend`
  width: 98px;
  height: 98px;
  margin-right: 1.2em;
`;

// extending for button set password
const ButtonSetPassword = Button.extend`
  width: inherit;
  padding: 10px;
`;

// removing the padding-top for Panel
const Panel = PanelAdminUser.extend`
  padding-top: 0;
`;

const FormGroups = ({ className }) => (
  <div className={className}>
    <ContainerFlex>
      <FormGroupLeft>
        <Label>First Name</Label>
        <Text name="first-name" placeholder="First name" type="text" />
      </FormGroupLeft>
      <FormGroup>
        <Label>Last Name</Label>
        <Text name="last-name" placeholder="Last name" type="text" />
      </FormGroup>
    </ContainerFlex>
    <FormGroup>
      <Label>Email Address</Label>
      <Text name="email" placeholder="Email Address" type="email" />
    </FormGroup>
    <ButtonSetPassword light lightBorder>
      Send set password link
    </ButtonSetPassword>
  </div>
);

const PanelUserDetails = () => (
  <Panel title="User Details">
    <ContainerFlex>
      <FormUserAvatar image={iconUser} />
      <FormGroups />
    </ContainerFlex>
  </Panel>
);

export default PanelUserDetails;
