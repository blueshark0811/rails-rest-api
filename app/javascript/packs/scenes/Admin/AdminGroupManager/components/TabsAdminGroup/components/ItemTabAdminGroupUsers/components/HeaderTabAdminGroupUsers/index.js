import React from 'react';
// sub-components
import ButtonAdd from 'base_components/ButtonAdd';
import ButtonSecondary from './components/ButtonSecondary';
import HeaderItemTab from 'base_components/HeaderItemTab';

const HeaderAdminGroupUsers = ({ className }) => (
  <HeaderItemTab>
    <ButtonAdd text="Add User To Group" />
    <ButtonSecondary secondary>Deactivate</ButtonSecondary>
    <ButtonSecondary secondary>Activate</ButtonSecondary>
    <ButtonSecondary secondary>Remove</ButtonSecondary>
  </HeaderItemTab>
);

export default HeaderAdminGroupUsers;
