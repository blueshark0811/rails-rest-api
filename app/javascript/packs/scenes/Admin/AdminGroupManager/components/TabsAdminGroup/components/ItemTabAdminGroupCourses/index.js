import React from 'react';

import HeaderItemTab from 'base_components/HeaderItemTab';
import ButtonAdd from 'base_components/ButtonAdd';

import TableAdminGroupCourses from './components/TableAdminGroupCourses';

const ItemTabAdminGroupCourses = () => (
  <div>
    <HeaderItemTab>
      <ButtonAdd text="Add course to group" />
    </HeaderItemTab>
    <TableAdminGroupCourses />
  </div>
);

export default ItemTabAdminGroupCourses;
