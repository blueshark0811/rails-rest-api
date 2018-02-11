import React from 'react';
import styled from 'styled-components';

import UserAvatar from 'base_components/UserAvatar';
import avatar from 'resources/images/user.png';

// list messages item
const ListMessagesItem = styled(({ className }) => (
  <li className={className}>
    <a href="">
      <UserAvatar small image={avatar} />
      <div>
        <div>
          <span>John Jones</span>
          <span>22 Sep 4:00pm</span>
        </div>
        <p>
          Hi, Jane can you send me question I asked for the other day when you…
        </p>
      </div>
    </a>
  </li>
))`
  a {
    display: flex;
    padding: 1.3em;
    background: ${props => props.active && 'rgba(186, 186, 186, 0.21)'};
    transition: background 300ms ease-in;

    img {
      margin-right: 1em;
    }

    > div {
      font-size: 13px;
      color: #2d2d2d;

      > div {
        display: flex;
        justify-content: space-between;
        align-items: center;

        span:last-child {
          color: #7e7e7e;
          font-size: 10px;
        }
      }

      p {
        padding-right: 4em;
        margin-top: 0.2em;
      }
    }

    &:hover {
      background: rgba(186, 186, 186, 0.21);
    }
  }
`;

// List messages component
const ListMessages = styled(({ className }) => {
  return (
    <ul className={className}>
      <ListMessagesItem />
      <ListMessagesItem active />
    </ul>
  );
})`
  @media screen and (max-width: 767px) {
    height: 155px;
    overflow-y: auto;
  }
`;

export default ListMessages;
