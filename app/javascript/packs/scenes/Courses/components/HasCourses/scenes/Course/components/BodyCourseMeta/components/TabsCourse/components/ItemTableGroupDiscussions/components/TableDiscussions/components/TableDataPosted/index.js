import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';

const TableDataPosted = styled(({ discussion, className }) => (
  <td className={className}>
    <div>
      <p>{discussion.title}</p>
      <div>
        <span>{`Posted by ${discussion.name}`}</span>
        <span>{`${discussion.date.day} ${discussion.date.time}`}</span>
      </div>
    </div>
  </td>
))`
  & > div {
    p {
      color: #111111;
      font-size: 16px;
      margin-bottom: 0.2em;
    }
    span {
      font-size: 10px;
    }
    span:first-child {
      color: #1e1e1e;
      margin-right: 0.8em;
    }
    span:last-child {
      color: #7e7e7e;
    }
  }
`;

TableDataPosted.propTypes = {
  discussion: PropTypes.object.isRequired
};

export default TableDataPosted;
