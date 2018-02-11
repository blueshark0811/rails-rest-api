import React from 'react';
// for Tab Component
import { Tab } from 'react-bootstrap';
import Tabs from 'base_components/Tabs';
// base components.
import ContainerBodyAdmin from '../../../components/ContainerAdminPanel/components/ContainerBodyAdmin';
// sub components
import ItemTabAdminGroupSettings from './components/ItemTabAdminGroupSettings';
import ItemTabAdminGroupUsers from './components/ItemTabAdminGroupUsers';
import ItemTabAdminGroupCourses from './components/ItemTabAdminGroupCourses';

// settings admin manager group.
const TabsAdminGroup = () => (
  <ContainerBodyAdmin>
    <Tabs>
      <Tab eventKey={1} title="Courses">
        <ItemTabAdminGroupCourses />
      </Tab>
      <Tab eventKey={2} title="Users">
        <ItemTabAdminGroupUsers />
      </Tab>
      <Tab eventKey={3} title="Settings">
        <ItemTabAdminGroupSettings />
      </Tab>
    </Tabs>
  </ContainerBodyAdmin>
);

export default TabsAdminGroup;
