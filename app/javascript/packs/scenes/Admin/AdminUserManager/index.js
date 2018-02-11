import React from 'react';
// Containers
import ContainerAdminPanel from '../components/ContainerAdminPanel';
import FilterableListAdminUser from './components/FilterableListAdminUser';
import FormAdminUser from './components/FormAdminUser';

const AdminUserManager = () => (
  <ContainerAdminPanel>
    <FilterableListAdminUser />
    <FormAdminUser />
  </ContainerAdminPanel>
);

export default AdminUserManager;
