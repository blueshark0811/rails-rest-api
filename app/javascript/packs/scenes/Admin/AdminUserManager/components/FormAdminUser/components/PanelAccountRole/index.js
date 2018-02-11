import React from 'react';
import styled from 'styled-components';
// components
import PanelAdminUser from '../PanelAdminUser';
import DropdownUserRole from './components/DropdownUserRole';
import AccountContainer from './components/AccountContainer';
import MessengerAccess from './components/MessengerAccess';

const PanelFormAccountRole = styled(PanelAdminUser)`
  border-top: 1px solid #dadada;
`;

const PanelAccountRole = () => (
  <PanelFormAccountRole title="Account Role">
    <DropdownUserRole />
    <AccountContainer />
    <MessengerAccess />
  </PanelFormAccountRole>
);

export default PanelAccountRole;
