import React from 'react';
import styled from 'styled-components';
// components
import ContainerFlex from 'base_components/ContainerFlex';
import Panel from 'base_components/Panel';
import ButtonAdd from 'base_components/ButtonAdd';
import ListGroups from './components/ListGroups';

// button add group
const ButtonAddGroup = styled(ButtonAdd)`
  border: 1px solid #979797;
  background: transparent;
  color: #000000;
  margin-right: 0;

  &:hover {
    background-color: #e2e2e2;
    color: #000000;
  }
`;

const TextHint = styled.p`
  width: 20%;
  font-size: 0.79rem;
  color: #777777;
`;

const PanelGroups = styled(({ className }) => (
  <Panel
    title="Groups"
    AdditionalTitle={() => <ButtonAddGroup text="Add group" />}
    className={className}
  >
    <ContainerFlex>
      <ListGroups />
      <TextHint>
        To remove a user from a group you must go to Group Manager > Users.
      </TextHint>
    </ContainerFlex>
  </Panel>
))`
  width: 100%;
  border-bottom: 0;

  header {
    width: 75%;
  }
`;

export default PanelGroups;
