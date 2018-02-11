import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';
import ModalBody from 'react-bootstrap/lib/ModalBody';

import UserAvatar from 'base_components/UserAvatar';

const ListRow = styled.li`
  padding: 1em 0;
  border-bottom: 1px solid #dadada;

  div {
    display: flex;
    align-items: center;

    > div {
      display: flex;
      flex-direction: column;
      align-items: flex-start;
      font-size: 10px;
      width: 8%;

      img {
        margin-bottom: 0.7em;
      }

      span {
        color: #7e7e7e;
      }
      span:nth-child(2) {
        color: #1e1e1e;
      }
    }
  }
`;

const ThreadModalBody = styled(({ className, thread }) => {
  const commentList = thread.comments.map(comment => (
    <ListRow key={comment.id}>
      <div>
        <div>
          <UserAvatar image={comment.avatarURL} />
          <span>{comment.name}</span>
          <span>{comment.date.day}</span>
          <span>{comment.date.time}</span>
        </div>
        <p>{comment.comment}</p>
      </div>
    </ListRow>
  ));
  return (
    <ModalBody className={className}>
      <div>
        <header>
          <h3>{thread.title}</h3>
          <p>{`Posted by ${thread.name}`}</p>
          <p>{`${thread.date.day} ${thread.date.time}`}</p>
        </header>
        <ul>{commentList}</ul>
      </div>
    </ModalBody>
  );
})`
  > div {
    max-width: 774px;
    margin: 0 auto;

    header {
      border-bottom: 1px solid #dadada;
    }

    p {
      display: inline-block;
      color: #1e1e1e;
    }

    p:last-child {
      color: #7e7e7e;
      margin-left: 0.8em;
    }
    h3 {
      margin-top: 0.5em;
      font-size: 1.6rem;
      color: #111111;
      text-align: left;
      max-width: 493px;
    }
  }
`;

ThreadModalBody.propTypes = {
  thread: PropTypes.object.isRequired
};

export default ThreadModalBody;
