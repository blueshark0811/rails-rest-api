import React from 'react';
// sub components
import RoleUser from 'base_components/RoleUser';
import StatusUser from './components/StatusUser';
// base components
import { TableRow, Td } from 'base_components/Tables';
import UserAvatar from 'base_components/UserAvatar';
import iconUser from 'resources/images/user.png';
import Button from 'base_components/RootButton';
import Form, { Checkbox } from 'base_components/RootForm';

// compose a table data.
const TableDataGroupUser = ({ children }) => <Td center>{children}</Td>;

const RowsTableAdminGroupUsers = () => (
  <tbody>
    <TableRow>
      <TableDataGroupUser>
        <Form>
          <Checkbox name="user-control-checkbox" />
        </Form>
      </TableDataGroupUser>
      <TableDataGroupUser>
        <UserAvatar image={iconUser} small />
      </TableDataGroupUser>
      <TableDataGroupUser>Doe</TableDataGroupUser>
      <TableDataGroupUser>Jane</TableDataGroupUser>
      <TableDataGroupUser>22/03/2017</TableDataGroupUser>
      <TableDataGroupUser>
        <StatusUser isActive={true} />
      </TableDataGroupUser>
      <TableDataGroupUser>
        <RoleUser roleUser="Teacher" />
      </TableDataGroupUser>
      <TableDataGroupUser>
        <Button light lightBorder>
          User Details
        </Button>
      </TableDataGroupUser>
    </TableRow>
    <TableRow>
      <TableDataGroupUser>
        <Form>
          <Checkbox name="user-control-checkbox" />
        </Form>
      </TableDataGroupUser>
      <TableDataGroupUser>
        <UserAvatar image={iconUser} small />
      </TableDataGroupUser>
      <TableDataGroupUser>Hall</TableDataGroupUser>
      <TableDataGroupUser>Tim</TableDataGroupUser>
      <TableDataGroupUser>22/03/2017</TableDataGroupUser>
      <TableDataGroupUser>
        <StatusUser isActive={true} />
      </TableDataGroupUser>
      <TableDataGroupUser />
      <TableDataGroupUser>
        <Button light lightBorder>
          User Details
        </Button>
      </TableDataGroupUser>
    </TableRow>
  </tbody>
);

export default RowsTableAdminGroupUsers;
