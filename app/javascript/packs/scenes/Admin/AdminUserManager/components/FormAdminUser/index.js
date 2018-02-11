import React from 'react';
import styled from 'styled-components';
// Container
import ContainerBodyAdmin from '../../../components/ContainerAdminPanel/components/ContainerBodyAdmin';
// form
import Form from 'base_components/RootForm';
import ButtonUpdate from 'base_components/ButtonUpdate';
// sub-components
import PanelUserDetails from './components/PanelUserDetails';
import PanelOtherInfo from './components/PanelOtherInfo';
import PanelGroups from './components/PanelGroups';
import PanelAccountRole from './components/PanelAccountRole';
import PanelControlGroup from './components/PanelControlGroup';

// extend-form
const MainForm = styled(Form)`
  width: 100%;
`;

const FormAdminUser = () => (
  <ContainerBodyAdmin>
    <MainForm>
      <PanelUserDetails />
      <PanelOtherInfo />
      <PanelGroups />
      <PanelAccountRole />
      <PanelControlGroup />
      <ButtonUpdate>Update</ButtonUpdate>
    </MainForm>
  </ContainerBodyAdmin>
);

export default FormAdminUser;
