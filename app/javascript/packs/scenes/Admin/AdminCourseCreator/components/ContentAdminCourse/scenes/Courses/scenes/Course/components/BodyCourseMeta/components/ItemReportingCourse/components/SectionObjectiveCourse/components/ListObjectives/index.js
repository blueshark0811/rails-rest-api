import React from 'react';
import styled from 'styled-components';
//
import ContainerFlex from 'base_components/ContainerFlex';
import Dropdown from 'base_components/Dropdown';
import { MenuItem } from 'react-bootstrap';
import { Label } from 'base_components/RootForm';
import Spinner from 'base_components/Spinner';
import IconMenu from 'react-icons/lib/md/dehaze';
import IconClose from 'react-icons/lib/md/close';

const ContainerButton = styled.div`
  display: flex;
  flex-direction: column;
  margin-right: 2.4em;
  text-align: center;

  label {
    color: #727272;
    font-size: 0.7rem;
    margin-top: 1em;
  }
`;

const DropdownResult = Dropdown.extend`
  width: 100%;
`;

const ListItem = styled(({ className }) => (
  <li className={className}>
    <ContainerFlex isSpaceBetween>
      <ContainerFlex isAlignCenter className="ListItem__title">
        <i>
          <IconMenu />
        </i>
        <span>Complete all the lessons</span>
      </ContainerFlex>
      <ContainerFlex isAlignCenter className="ListItem__action">
        <ContainerButton>
          <DropdownResult title="Pass/Fail" id="dropdown-size-medium">
            <MenuItem eventKey="1">Percentage</MenuItem>
            <MenuItem eventKey="2">Pass/Fail</MenuItem>
            <MenuItem eventKey="3">Competency</MenuItem>
            <MenuItem eventKey="4">Manual Entry</MenuItem>
          </DropdownResult>
          <Label>Assesment Method</Label>
        </ContainerButton>
        <ContainerButton>
          <Spinner />
          <Label>Weight of Mark</Label>
        </ContainerButton>
        <i>
          <IconClose />
        </i>
      </ContainerFlex>
    </ContainerFlex>
  </li>
))`
  padding: 1.2em 0.8em 1.2em;
  border-bottom: 1px solid #d8d8d8;

  .ListItem__title {
    i {
      color: #d8d8d8;
      margin-right: 1.2em;
    }
  }

  .ListItem__action {
    > i {
      color: #afafaf;
      font-size: 1.4rem;
    }
  }
`;

const List = styled.ul`
  border: 1px solid #d8d8d8;
  padding-bottom: 1.5em;
  overflow: auto;
`;

const ListObjectives = () => (
  <List>
    <ListItem />
    <ListItem />
    <ListItem />
  </List>
);

export default ListObjectives;
