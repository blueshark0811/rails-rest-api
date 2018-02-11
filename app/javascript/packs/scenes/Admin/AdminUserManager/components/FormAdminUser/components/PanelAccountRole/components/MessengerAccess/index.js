import React from 'react';
import styled from 'styled-components';
// components/
import ContainerFlex from 'base_components/ContainerFlex';
import { Label, Switch } from 'base_components/RootForm';

const SwitchMessenger = styled(Switch)`
  margin-right: 1.8em;
`;

const MessengerAccess = () => (
  <ContainerFlex isSpaceBetween>
    <Label>Messenger Access</Label>
    <SwitchMessenger name="messengerAccess" />
  </ContainerFlex>
);

export default MessengerAccess;
