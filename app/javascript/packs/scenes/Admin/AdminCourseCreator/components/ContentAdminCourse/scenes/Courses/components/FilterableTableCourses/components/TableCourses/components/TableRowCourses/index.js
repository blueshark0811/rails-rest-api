import React from 'react';
import styled from 'styled-components';
import IconUser from 'react-icons/lib/fa/user';
//
import { TableRow, Td } from 'base_components/Tables';
import LinkButton from 'base_components/LinkButton';
import ContainerFlex from 'base_components/ContainerFlex';

// Table data for name column
const TableDataName = styled.td`
  p {
    font-size: 16px;
    margin-bottom: 0.4em;
  }

  span {
    color: #9fa6ad;
    max-width: 350px;
    display: inline-block;
  }
`;

// container for active user
const ContainerActiveUser = ContainerFlex.extend`
  justify-content: center;

  i {
    color: #9fa6ad;
    margin-right: 0.3em;
  }
`;

// for text
const Text = styled.span`
  font-size: 16px;
`;

/* const ButtonDetails = Button.extend`
 *   @media screen and (min-width: 768px) {
 *     width: 140px;
 *   }
 * `;*/

const TableRowCourses = () => (
  <tbody>
    <TableRow>
      <TableDataName>
        <p>Communication and Culture</p>
        <span>
          This group is for people who are in level 3 pathway in the Connect
          Program.
        </span>
      </TableDataName>
      <Td center>
        <Text>19 March 17</Text>
      </Td>
      <Td center>
        <ContainerActiveUser isAlignCenter>
          <i>
            <IconUser />
          </i>
          <Text>33</Text>
        </ContainerActiveUser>
      </Td>
      <Td center>
        <Text>8</Text>
      </Td>
      <Td>
        <LinkButton
          url="/admin/course-creator/courses/communication-and-culture"
          text="Details"
        />
      </Td>
    </TableRow>
    <TableRow>
      <TableDataName>
        <p>Language and Culture</p>
        <span>
          This group is for people who are in level 3 pathway in the Connect
          Program.
        </span>
      </TableDataName>
      <Td center>
        <Text>19 March 17</Text>
      </Td>
      <Td center>
        <ContainerActiveUser isAlignCenter>
          <i>
            <IconUser />
          </i>
          <Text>44</Text>
        </ContainerActiveUser>
      </Td>
      <Td center>
        <Text>5</Text>
      </Td>
      <Td>
        <LinkButton
          url="/admin/course-creator/courses/language-and-culture"
          text="Details"
        />
      </Td>
    </TableRow>
  </tbody>
);

export default TableRowCourses;
