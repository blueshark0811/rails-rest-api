import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';

import TableData from '../TableData';
import UserAvatar from 'base_components/UserAvatar';

const TableDataActivity = styled(({ activity, className }) => (
  <TableData style={{ textAlign: 'center' }} className={className}>
    <div>
      <UserAvatar small image={activity.avatarURL} />
      <div>
        <span>{activity.name}</span>
        <span>{activity.date.day}</span>
        <span>{activity.date.time}</span>
      </div>
    </div>
  </TableData>
))`
  > div {
    display: flex;

    div {
      display: flex;
      flex-direction: column;
      font-size: 10px;
      margin-left: 0.7em;
      text-align: left;

      span:first-child {
        color: #1e1e1e;
      }
      span:nth-last-child(-n + 2) {
        color: #7e7e7e;
      }
    }
  }
`;

TableDataActivity.propTypes = {
  activity: PropTypes.object.isRequired
};

export default TableDataActivity;
