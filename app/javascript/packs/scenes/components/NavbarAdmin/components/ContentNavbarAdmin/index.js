import React from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';
import IconArrowBack from 'react-icons/lib/md/arrow-back';

import ListLinkAdminVertical from '../ListLinkAdminVertical';
import logo from 'resources/images/logo.svg';
import IconBurger from 'react-icons/lib/fa/align-justify';

// Content navbar admin
const ContentNavbarAdmin = styled(({ className, onToggle }) => (
  <div className={className}>
    <div>
      <Link to="/">
        <img alt="Logo" src={logo} />
      </Link>
      <ListLinkAdminVertical />
    </div>
    <Link to="/">
      <span>
        <IconArrowBack />
      </span>
      Main Site
    </Link>
    <button onClick={onToggle}>
      <IconBurger />
    </button>
  </div>
))`
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 2%;

  > a {
    display: none;
    color: #9fa6ad;
    font-weight: 800;
    font-size: 0.78rem;
    text-transform: uppercase;
    transition: all 300ms ease-in;

    &:hover {
      color: #0e90e0;
    }

    span {
      font-size: 1rem;
      margin-right: 0.3em;
    }
  }

  > button {
    border: 0;
    background: transparent;
    color: #ffffff;
    font-size: 1.6rem;
    padding: 0;
  }

  @media screen and (min-width: 768px) {
    padding: 0;

    > div:first-child {
      display: flex;
      width: 620px;
      align-items: center;
    }

    > a {
      display: block;
    }

    > button {
      display: none;
    }
  }
`;

export default ContentNavbarAdmin;
