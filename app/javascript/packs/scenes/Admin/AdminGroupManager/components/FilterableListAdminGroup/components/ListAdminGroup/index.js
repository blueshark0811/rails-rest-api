import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';

import IconUser from 'react-icons/lib/fa/user';

// this is for list group
const ListItem = styled(({ className }) => (
  <li className={className}>
    <span>Connect: Level 3</span>
    <div>
      <span>
        <IconUser />
      </span>
      <span>22/40</span>
    </div>
  </li>
))`
  padding: 20px 17px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  background-color: ${props => props.active && 'rgba(184, 184, 184, .2)'};
  color: #111111;

  > div span:first-child {
    font-size: 1.1rem;
    color: #9fa6ad;
    margin-right: 0.3em;
  }

  @media screen and (min-width: 768px) {
    padding: 24px 35px;
  }
`;

const ListAdminGroup = () => (
  <ul>
    <ListItem />
    <ListItem active />
  </ul>
);

ListAdminGroup.propTypes = {
  active: PropTypes.bool
};

export default ListAdminGroup;
