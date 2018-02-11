import React from 'react';
import styled from 'styled-components';
import IconMenu from 'react-icons/lib/fa/align-justify';
// sub-components
import ModalCoursesSettings from './components/ModalCoursesSettings';
// base components
import { TableRow, Td } from 'base_components/Tables';
import StatusCircle from 'base_components/StatusCircle';
import Button from 'base_components/RootButton';
// assets
import iconPauseButton from 'resources/images/iconPauseButton.svg';

// compose a table data.
const TableDataGroupUser = ({ children }) => <Td center>{children}</Td>;

// compse IconMenuContainer styled component.
const IconMenuContainer = styled.i`
  color: #e3e3e3;
`;

// compose buttons
const ButtonCourseDetails = Button.extend`
  width: 125px;
`;

const RowsTableAdminGroupCourses = () => (
  <tbody>
    <TableRow>
      <td>
        <IconMenuContainer>
          <IconMenu />
        </IconMenuContainer>
      </td>
      <TableDataGroupUser>Communication and Culture</TableDataGroupUser>
      <TableDataGroupUser>22/03/17</TableDataGroupUser>
      <TableDataGroupUser>
        <StatusCircle state="active" />
      </TableDataGroupUser>
      <TableDataGroupUser>
        <div>
          <ModalCoursesSettings />
          <ButtonCourseDetails light lightBorder>
            Course Details
          </ButtonCourseDetails>
        </div>
      </TableDataGroupUser>
    </TableRow>
    <TableRow>
      <td>
        <IconMenuContainer>
          <IconMenu />
        </IconMenuContainer>
      </td>
      <TableDataGroupUser>Becoming Equipped to Communicate</TableDataGroupUser>
      <TableDataGroupUser>22/03/17</TableDataGroupUser>
      <TableDataGroupUser>
        <img alt="icon pause button" src={iconPauseButton} />
      </TableDataGroupUser>
      <TableDataGroupUser>
        <div>
          <ModalCoursesSettings />
          <ButtonCourseDetails light lightBorder>
            Course Details
          </ButtonCourseDetails>
        </div>
      </TableDataGroupUser>
    </TableRow>
  </tbody>
);

export default RowsTableAdminGroupCourses;
