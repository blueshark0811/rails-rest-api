import React from 'react';
// Container
import ContainerFilterableList from '../../../components/ContainerAdminPanel/components/ContainerFilterableList';
// sub components
import SearchbarListAdminUser from './components/SearchbarListAdminUser';
import ListAdminUser from './components/ListAdminUser';

const FilterableListAdminUser = () => (
  <ContainerFilterableList>
    <SearchbarListAdminUser />
    <ListAdminUser />
  </ContainerFilterableList>
);

export default FilterableListAdminUser;
