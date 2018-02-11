import React from 'react';

import Form from 'base_components/RootForm';
import ButtonUpdate from 'base_components/ButtonUpdate';
// sub-components
import PanelGeneralInfo from './components/PanelGeneralInfo';
import PanelUsers from './components/PanelUsers';
import PanelGroupNoticeBoard from './components/PanelGroupNoticeBoard';
import PanelControlGroup from './components/PanelControlGroup';

const ItemTabAdminGroupSettings = () => (
  <Form>
    <PanelGeneralInfo />
    <PanelUsers />
    <PanelGroupNoticeBoard />
    <PanelControlGroup />
    <ButtonUpdate>Update</ButtonUpdate>
  </Form>
);

export default ItemTabAdminGroupSettings;
