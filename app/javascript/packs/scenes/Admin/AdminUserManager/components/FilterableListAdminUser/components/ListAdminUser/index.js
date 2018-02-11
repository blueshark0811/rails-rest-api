import React from 'react';
import styled from 'styled-components';
// user avatar
import UserAvatar from 'base_components/UserAvatar';
import iconUser from 'resources/images/user.png';
// some sub components
import RoleUser from 'base_components/RoleUser';
import ContainerFlex from 'base_components/ContainerFlex';
import StatusCircle from 'base_components/StatusCircle';

// Handling the list item of the list admin user
const ListItemAdminUser = styled(({ className }) => (
  <li className={className}>
    <ContainerFlex isSpaceBetween>
      <ContainerFlex isAlignCenter>
        <UserAvatar image={iconUser} />
        <span>Tim Hall</span>
      </ContainerFlex>
      <ContainerFlex isAlignCenter>
        <RoleUser roleUser="Teacher" />
        <StatusCircle state="disabled" />
      </ContainerFlex>
    </ContainerFlex>
  </li>
))`
  background-color: none;
  padding: 17px 35px;
  transition: all 300ms ease-in;
  cursor: pointer;

  &:hover {
    background-color: rgba(184, 184, 184, 0.2);
  }

  > div > div {
    &:first-child {
      span {
        margin-left: 1em;
      }
    }

    &:last-child {
      > div {
        margin-right: 1em;
      }
    }
  }
`;

const ListAdminUser = () => (
  <ul>
    <ListItemAdminUser />
    <ListItemAdminUser />
  </ul>
);

export default ListAdminUser;
