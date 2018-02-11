import React from 'react';
import styled from 'styled-components';

import './styles.css';
import Table, { TableRow } from 'base_components/Tables';
import DateTime from 'base_components/DateTime';
import UserAvatar from 'base_components/UserAvatar';
import iconUser from 'resources/images/user.png';

// the container component for our activity.
const ContainerActivity = styled.div`
  display: flex;
`;

// avatar that we will use to our activity table data.
const AvatarActivity = UserAvatar.extend`
  margin-right: 1em;
`;

const TableTeacherGroupsActivity = () => (
  <Table>
    <thead>
      <TableRow>
        <th>Time</th>
        <th>Course</th>
        <th>Activity</th>
      </TableRow>
    </thead>
    <tbody>
      <TableRow>
        <td>
          <DateTime date="22 Sep" time="2:00pm" />
        </td>
        <td>
          <p>Becoming Equipped to Communicate</p>
        </td>
        <td>
          <ContainerActivity>
            <AvatarActivity image={iconUser} />
            <p>
              Jane <strong>wrote something in</strong>{' '}
              <em>
                How does our culture impact decisions made by the government?
              </em>
            </p>
          </ContainerActivity>
        </td>
      </TableRow>
      <TableRow>
        <td>
          <DateTime date="22 Sep" time="2:00pm" />
        </td>
        <td>
          <p>Becoming Equipped to Communicate</p>
        </td>
        <td>
          <ContainerActivity>
            <AvatarActivity image={iconUser} />
            <p>
              Jane <strong>wrote something in</strong>{' '}
              <em>
                How does our culture impact decisions made by the government?
              </em>
            </p>
          </ContainerActivity>
        </td>
      </TableRow>
    </tbody>
  </Table>
);

export default TableTeacherGroupsActivity;
