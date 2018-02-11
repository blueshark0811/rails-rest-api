import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';
import { NavLink } from 'react-router-dom';
//
import UserAvatar from 'base_components/UserAvatar';

const ListLinkItem = styled(({ className, icon, text, url }) => (
  <NavLink
    className={className}
    to={url}
    activeStyle={{
      backgroundColor: '#25282A'
    }}
  >
    <UserAvatar image={icon} />
    <span>{text}</span>
  </NavLink>
))`
  display: block;
  padding: 20px;
  transition: all 300ms ease-in;

  &:hover {
    background-color: #25282a;
  }

  img {
    border-radius: 0;
  }

  span {
    display: none;
  }

  @media screen and (min-width: 768px) {
    display: flex;
    flex-direction: column;
    padding: 18px 35px;
    align-items: center;

    img {
      height: 45px;
      width: 45px;
    }

    span {
      display: inline-block;
      color: #9fa6ad;
      font-family: karla;
      font-weight: 800;
      font-size: 12px;
      margin-top: 0.5em;
      width: 57px;
      text-align: center;
      text-transform: uppercase;
      line-height: 1.4;
    }
  }
`;

ListLinkItem.propTypes = {
  icon: PropTypes.string.isRequired,
  text: PropTypes.string.isRequired,
  url: PropTypes.string.isRequired
};

export default ListLinkItem;
